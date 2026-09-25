params [
    ["_spawnBase", objNull, [objNull]],
    ["_className", "", [""]],
    ["_openEditor", false, [false]],
    ["_caller", objNull, [objNull]]
];

if (!isServer) exitWith {};
if (isNull _caller || {!isPlayer _caller}) exitWith {};

private _callerOwner = owner _caller;
if (isRemoteExecuted && {remoteExecutedOwner != _callerOwner}) exitWith {};

private _reply = {
    params ["_success", "_message", ["_vehicle", objNull, [objNull]]];
    [_success, _message, _vehicle, _openEditor] remoteExecCall ["D207_fnc_VehicleSpawnResult", _callerOwner];
};

if (isNull _spawnBase) exitWith {[false, "Vehicle spawn failed: spawner no longer exists."] call _reply;};
if (_caller distance _spawnBase > 15) exitWith {[false, "You are too far away from the vehicle spawner."] call _reply;};
if !(isClass (configFile >> "CfgVehicles" >> _className)) exitWith {[false, "Vehicle spawn failed: invalid vehicle class."] call _reply;};
if (_spawnBase getVariable ["D207_spawnBusy", false]) exitWith {[false, "This vehicle spawner is already processing another request."] call _reply;};

private _lists = [
    missionNamespace getVariable ["D207_VehicleListPlatoon", []],
    missionNamespace getVariable ["D207_VehicleListFoxtrot", []],
    missionNamespace getVariable ["D207_VehicleListHawkeye", []],
    missionNamespace getVariable ["D207_VehicleListDrone", []]
];
private _lockVariables = ["D207_VehiclePlatoon", "D207_VehicleFoxtrot", "D207_VehicleHawkeye", "D207_VehicleDrone"];
private _ticketVariables = ["D207_PlatoonTickets", "D207_FoxtrotTickets", "D207_HawkeyeTickets", "D207_DroneTickets"];
private _categoryNames = ["Platoon", "Foxtrot", "Hawkeye", "Drone"];

// If a class is accidentally present in more than one list, the first list is
// authoritative for both charging and refunding tickets.
private _categoryIndex = _lists findIf {_className in _x};
if (_categoryIndex < 0) exitWith {[false, "That vehicle is not in an allowed vehicle-spawner list."] call _reply;};

private _locked = missionNamespace getVariable [_lockVariables select _categoryIndex, false];
if (_locked) exitWith {[false, format ["%1 vehicle spawning is currently disabled. Ping a Zeus.", _categoryNames select _categoryIndex]] call _reply;};

_spawnBase setVariable ["D207_spawnBusy", true, true];

private _checkPosition = _spawnBase modelToWorld [0, 20, 0];
private _safePosition = _spawnBase modelToWorld [0, -5, 0];
private _vehiclesInSpawn = nearestObjects [_checkPosition, ["LandVehicle", "Air", "Ship"], 10, true];
_vehiclesInSpawn = _vehiclesInSpawn select {_x != _spawnBase};

// Work out the complete ticket transaction before disturbing an old vehicle.
private _refunds = [0, 0, 0, 0];
{
    private _oldClass = typeOf _x;
    private _refundIndex = _lists findIf {_oldClass in _x};
    if (_refundIndex >= 0) then {
        _refunds set [_refundIndex, (_refunds select _refundIndex) + 1];
    };
} forEach _vehiclesInSpawn;

private _ticketValues = _ticketVariables apply {missionNamespace getVariable [_x, 0]};
private _projectedTickets = (_ticketValues select _categoryIndex) + (_refunds select _categoryIndex);
if (_projectedTickets <= 0) exitWith {
    _spawnBase setVariable ["D207_spawnBusy", false, true];
    [false, format ["You have no more tickets to spawn %1 vehicles.", _categoryNames select _categoryIndex]] call _reply;
};

// Human occupants must be moved out on their owning clients. Wait for that to
// finish before any vehicle in the spawn area is deleted.
private _playerCrew = [];
{
    {
        if (isPlayer _x) then {
            _playerCrew pushBackUnique _x;
            [_x, _safePosition] remoteExecCall ["D207_fnc_EjectVehiclePlayer", owner _x];
        };
    } forEach crew _x;
} forEach _vehiclesInSpawn;

if (_playerCrew isNotEqualTo []) then {
    private _ejectTimeout = diag_tickTime + 3;
    waitUntil {
        uiSleep 0.05;
        ({!isNull (objectParent _x) && {(objectParent _x) in _vehiclesInSpawn}} count _playerCrew) isEqualTo 0 || {diag_tickTime >= _ejectTimeout}
    };
};
private _ejectFailed = ({!isNull (objectParent _x) && {(objectParent _x) in _vehiclesInSpawn}} count _playerCrew) > 0;
if (_ejectFailed) exitWith {
    _spawnBase setVariable ["D207_spawnBusy", false, true];
    [false, "Vehicle spawn cancelled because a player could not be safely ejected from the old spawn area."] call _reply;
};

// Remove AI crew where the vehicle is local. This avoids the ghost-crew issues
// that can occur when deleteVehicleCrew is run from the wrong machine.
{
    private _oldVehicle = _x;
    if (((crew _oldVehicle) findIf {!isPlayer _x}) >= 0) then {
        if (local _oldVehicle) then {
            deleteVehicleCrew _oldVehicle;
        } else {
            _oldVehicle remoteExecCall ["deleteVehicleCrew", _oldVehicle];
        };
    };
} forEach _vehiclesInSpawn;

private _crewDeleteTimeout = diag_tickTime + 2;
waitUntil {
    uiSleep 0.05;
    ({((crew _x) findIf {!isPlayer _x}) >= 0} count _vehiclesInSpawn) isEqualTo 0 || {diag_tickTime >= _crewDeleteTimeout}
};
private _crewDeleteFailed = ({((crew _x) findIf {!isPlayer _x}) >= 0} count _vehiclesInSpawn) > 0;
if (_crewDeleteFailed) exitWith {
    _spawnBase setVariable ["D207_spawnBusy", false, true];
    [false, "Vehicle spawn cancelled because AI crew in the old spawn area could not be removed cleanly."] call _reply;
};

{deleteVehicle _x;} forEach _vehiclesInSpawn;

// Commit the refunds only after the old vehicles were successfully cleared.
for "_i" from 0 to 3 do {
    _ticketValues set [_i, (_ticketValues select _i) + (_refunds select _i)];
};

private _isWater = surfaceIsWater _checkPosition;
private _spawnPosition = if (_isWater) then {_spawnBase modelToWorld [0, 20, 3]} else {_checkPosition};
private _vehicle = createVehicle [_className, _spawnPosition, [], 0, "CAN_COLLIDE"];

if (isNull _vehicle) exitWith {
    // The old vehicles are gone, so keep their refunds even though the new
    // vehicle failed to create.
    for "_i" from 0 to 3 do {
        missionNamespace setVariable [_ticketVariables select _i, _ticketValues select _i, true];
    };
    _spawnBase setVariable ["D207_spawnBusy", false, true];
    [false, "Vehicle spawn failed after the old spawn area was cleared. Any refunded vehicles were returned to the ticket totals."] call _reply;
};

_vehicle setDir (getDir _spawnBase);
if (_isWater) then {
    _vehicle setPosATL _spawnPosition;
} else {
    _vehicle setVehiclePosition [[_spawnPosition select 0, _spawnPosition select 1, 0], [], 0, "CAN_COLLIDE"];
};

if (unitIsUAV _vehicle) then {
    createVehicleCrew _vehicle;
    private _uavGroup = createGroup [side _caller, true];
    _uavGroup deleteGroupWhenEmpty true;
    (crew _vehicle) joinSilent _uavGroup;
    _uavGroup addVehicle _vehicle;
};

clearWeaponCargoGlobal _vehicle;
clearMagazineCargoGlobal _vehicle;
clearItemCargoGlobal _vehicle;
clearBackpackCargoGlobal _vehicle;

// Debit the new vehicle, then publish the complete set of totals once.
_ticketValues set [_categoryIndex, (_ticketValues select _categoryIndex) - 1];
for "_i" from 0 to 3 do {
    missionNamespace setVariable [_ticketVariables select _i, _ticketValues select _i, true];
};

if (_vehicle isKindOf "B_Truck_01_medical_F") then {
    ["CREATE", _vehicle] remoteExec ["D207_fnc_Relocator", -2, _vehicle];
};

_spawnBase setVariable ["D207_spawnBusy", false, true];
private _displayName = getText (configFile >> "CfgVehicles" >> _className >> "displayName");
if (_displayName isEqualTo "") then {_displayName = _className;};
[true, format ["You have spawned a %1", _displayName], _vehicle] call _reply;
