disableSerialization;

// Get selected vehicle BEFORE closing dialog
private _display = findDisplay 8100;
if (isNull _display) exitWith {
	hint "Vehicle spawn menu not found.";
};
private _ctrl = _display displayCtrl 1500;
private _index = lbCurSel _ctrl;
if (_index < 0) exitWith {
	hint "No vehicle selected.";
};
private _ctrlChecked = _display displayCtrl 2800;
private _openEditor = cbChecked _ctrlChecked;
private _info = _ctrl lbData _index;
closeDialog 1;
// Vehicle restriction checks
private _platoonList = missionNamespace getVariable ["D207_VehicleListPlatoon", []];
private _foxtrotList = missionNamespace getVariable ["D207_VehicleListFoxtrot", []];
private _hawkeyeList = missionNamespace getVariable ["D207_VehicleListHawkeye", []];
private _droneList = missionNamespace getVariable ["D207_VehicleListDrone", []];
private _platoonLocked = missionNamespace getVariable ["D207_VehiclePlatoon", false];
private _foxtrotLocked = missionNamespace getVariable ["D207_VehicleFoxtrot", false];
private _hawkeyeLocked = missionNamespace getVariable ["D207_VehicleHawkeye", false];
private _droneLocked = missionNamespace getVariable ["D207_VehicleDrone", false];
if ((_info in _platoonList) && {_platoonLocked}) exitWith {
	hint "You can not spawn Platoon Vehicles. Ping a Zeus";
};
if ((_info in _foxtrotList) && {_foxtrotLocked}) exitWith {
	hint "You can not spawn Foxtrot Vehicles. Ping a Zeus";
};
if ((_info in _hawkeyeList) && {_hawkeyeLocked}) exitWith {
	hint "You can not spawn Hawkeye Vehicles. Ping a Zeus";
};
if ((_info in _droneList) && {_droneLocked}) exitWith {
	hint "You can not spawn Drones at this time. Ping a Zeus";
};
// Base spawn info
private _spawnBase = SpawnBoxLOC;
private _dir = getDir _spawnBase;
// Main check position: 20m in front of SpawnBoxLOC
private _checkPosition = _spawnBase modelToWorld [0, 20, 0];
// Safe place to move players before deleting old vehicles
private _playerSafePos = _spawnBase modelToWorld [0, -5, 0];
// Clear all vehicles in spawn zone
private _vehiclesInSpawn = nearestObjects [
	_checkPosition,
	["LandVehicle", "Air", "Ship"],
	10,
	true
];
{
	private _oldVehicle = _x;
	// Remove crew safely before deleting vehicle
	{
		private _unit = _x;
		if (isPlayer _unit) then {
			unassignVehicle _unit;
			moveOut _unit;
			_unit setPosATL _playerSafePos;
		} else {
			deleteVehicle _unit;
		};
	} forEach crew _oldVehicle;
	sleep 0.1;
	deleteVehicle _oldVehicle;
	if ((typeOf _oldVehicle) in _platoonList) then {_Tickets = missionNamespace getVariable "D207_PlatoonTickets";_SetTickets = _Tickets + 1;missionNamespace setVariable ["D207_PlatoonTickets", _SetTickets, true];};
	if ((typeOf _oldVehicle) in _foxtrotList) then {_Tickets = missionNamespace getVariable "D207_FoxtrotTickets";_SetTickets = _Tickets + 1;missionNamespace setVariable ["D207_FoxtrotTickets", _SetTickets, true];};
	if ((typeOf _oldVehicle) in _hawkeyeList) then {_Tickets = missionNamespace getVariable "D207_HawkeyeTickets";_SetTickets = _Tickets + 1;missionNamespace setVariable ["D207_HawkeyeTickets", _SetTickets, true];};
	if ((typeOf _oldVehicle) in _droneList) then {_Tickets = missionNamespace getVariable "D207_DroneTickets";_SetTickets = _Tickets + 1;missionNamespace setVariable ["D207_DroneTickets", _SetTickets, true];};
} forEach _vehiclesInSpawn;
sleep 0.5;
_TicketsPlatoon = missionNamespace getVariable "D207_PlatoonTickets";
_TicketsFoxtrot = missionNamespace getVariable "D207_FoxtrotTickets";
_TicketsHawkeye = missionNamespace getVariable "D207_HawkeyeTickets";
_TicketsDrone = missionNamespace getVariable "D207_DroneTickets";
if ((_TicketsPlatoon <= 0) && (_info in _platoonList)) exitWith {hint "You Have no more Tickets to spawn Platoon Vehicles";};
if ((_TicketsFoxtrot <= 0) && (_info in _foxtrotList)) exitWith {hint "You Have no more Tickets to spawn Foxtrot Vehicles";};
if ((_TicketsHawkeye <= 0) && (_info in _hawkeyeList)) exitWith {hint "You Have no more Tickets to spawn Hawkeye Vehicles";};
if ((_TicketsDrone <= 0) && (_info in _droneList)) exitWith {hint "You Have no more Tickets to spawn Drone Vehicles";};
// Check if the spawn point is over water
private _isWater = surfaceIsWater _checkPosition;
private _spawnPosition = [];
if (_isWater) then {
	_spawnPosition = _spawnBase modelToWorld [0, 20, 3];
} else {
	_spawnPosition = _checkPosition;
};
// Spawn vehicle
private _vehicle = createVehicle [_info, _spawnPosition, [], 0, "CAN_COLLIDE"];
_vehicle setDir _dir;
if (_isWater) then {
	_vehicle setPosATL _spawnPosition;
} else {
	_vehicle setVehiclePosition [
		[_spawnPosition select 0, _spawnPosition select 1, 0],
		[],
		0,
		"CAN_COLLIDE"
	];
};
sleep 0.5;
// UAV crew setup
if (unitIsUAV _vehicle) then {
	private _playerSide = playerSide;
	private _newGroup = createGroup [_playerSide, true];
	createVehicleCrew _vehicle;
	private _crew = crew _vehicle;
	_crew joinSilent _newGroup;
	_newGroup addVehicle _vehicle;
};
// Clear vehicle cargo
clearWeaponCargoGlobal _vehicle;
clearMagazineCargoGlobal _vehicle;
clearItemCargoGlobal _vehicle;
clearBackpackCargoGlobal _vehicle;

// Medical respawn mover setup
if (_vehicle isKindOf "B_Truck_01_medical_F") then {
	[_vehicle] remoteExec ["D207_fnc_respawntele", 0, true];
};
sleep 0.5;
private _displayName = getText (configFile >> "CfgVehicles" >> _info >> "displayName");
private _chat = format ["You have spawned a %1", _displayName];
systemChat _chat;
[_vehicle,_openEditor] spawn {
    params ["_vehicle","_openEditor"];
	test1 = _vehicle;
	test2 = _openEditor;
    // Give the vehicle and mission display time to initialise.
    uiSleep 0.25;
    if (isNull _vehicle) exitWith {};

    if (_openEditor) then {
        [_vehicle] call D207_fnc_openVehicleEditor;
    };
};
if (_info in _platoonList) exitWith {
	_Tickets = missionNamespace getVariable "D207_PlatoonTickets";
	_SetTickets = _Tickets - 1;
	missionNamespace setVariable ["D207_PlatoonTickets", _SetTickets, true];
};
if (_info in _foxtrotList) exitWith {
	_Tickets = missionNamespace getVariable "D207_FoxtrotTickets";
	_SetTickets = _Tickets - 1;
	missionNamespace setVariable ["D207_FoxtrotTickets", _SetTickets, true];
};
if (_info in _hawkeyeList) exitWith {
	_Tickets = missionNamespace getVariable "D207_HawkeyeTickets";
	_SetTickets = _Tickets - 1;
	missionNamespace setVariable ["D207_HawkeyeTickets", _SetTickets, true];
};
if (_info in _droneList) exitWith {
	_Tickets = missionNamespace getVariable "D207_DroneTickets";
	_SetTickets = _Tickets - 1;
	missionNamespace setVariable ["D207_DroneTickets", _SetTickets, true];
};