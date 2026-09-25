params [["_box", objNull, [objNull]]];
if (!isNull _box) then {missionNamespace setVariable ["SpawnBoxLOC", _box];};

private _spawnBox = missionNamespace getVariable ["SpawnBoxLOC", objNull];
if (isNull _spawnBox) exitWith {hint "Vehicle spawner reference is missing.";};

createDialog "VehicleSpawnerStart";
private _display = findDisplay 8000;
private _ctrlPLT = _display displayCtrl 1601;
private _ctrlFOX = _display displayCtrl 1602;
private _ctrlHAW = _display displayCtrl 1603;
private _ctrlDrone = _display displayCtrl 1604;
private _control1 = _display displayCtrl 1605;
private _control2 = _display displayCtrl 1606;
ctrlSetFocus _control1;

private _pltLocked = missionNamespace getVariable ["D207_VehiclePlatoon", false];
private _foxLocked = missionNamespace getVariable ["D207_VehicleFoxtrot", false];
private _hawLocked = missionNamespace getVariable ["D207_VehicleHawkeye", false];
private _droneLocked = missionNamespace getVariable ["D207_VehicleDrone", false];

_ctrlPLT ctrlSetBackgroundColor (if (_pltLocked) then {[0.7,0,0,0.5]} else {[0,0.7,0,0.5]});
_ctrlFOX ctrlSetBackgroundColor (if (_foxLocked) then {[0.7,0,0,0.5]} else {[0,0.7,0,0.5]});
_ctrlHAW ctrlSetBackgroundColor (if (_hawLocked) then {[0.7,0,0,0.5]} else {[0,0.7,0,0.5]});
_ctrlDrone ctrlSetBackgroundColor (if (_droneLocked) then {[0.7,0,0,0.5]} else {[0,0.7,0,0.5]});

{
    _x ctrlSetBackgroundColor [0,0,0,1];
    _x ctrlSetForegroundColor [0,0,0,1];
    _x ctrlSetActiveColor [0,0,0,1];
} forEach [_control1, _control2];
