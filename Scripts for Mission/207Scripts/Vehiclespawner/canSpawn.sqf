private _platoonLocked = missionNamespace getVariable ["D207_VehiclePlatoon", false];
private _foxtrotLocked = missionNamespace getVariable ["D207_VehicleFoxtrot", false];
private _hawkeyeLocked = missionNamespace getVariable ["D207_VehicleHawkeye", false];
private _droneLocked = missionNamespace getVariable ["D207_VehicleDrone", false];

private _platoon = if (_platoonLocked) then {"cannot"} else {"can"};
private _foxtrot = if (_foxtrotLocked) then {"cannot"} else {"can"};
private _hawkeye = if (_hawkeyeLocked) then {"cannot"} else {"can"};
private _drone = if (_droneLocked) then {"cannot"} else {"can"};

private _hintText1 = parseText format ["You %1 spawn Platoon vehicles.", _platoon];
private _hintText2 = parseText format ["You %1 spawn Foxtrot vehicles.", _foxtrot];
private _hintText3 = parseText format ["You %1 spawn Hawkeye vehicles.", _hawkeye];
private _hintText4 = parseText format ["You %1 spawn Drone vehicles.", _drone];
hint composeText [_hintText1, lineBreak, _hintText2, lineBreak, _hintText3, lineBreak, _hintText4];

private _display = findDisplay 8000;
if (isNull _display) exitWith {};
private _ctrlPLT = _display displayCtrl 1601;
private _ctrlFOX = _display displayCtrl 1602;
private _ctrlHAW = _display displayCtrl 1603;
private _ctrlDrone = _display displayCtrl 1604;

_ctrlPLT ctrlSetBackgroundColor (if (_platoonLocked) then {[0.7,0,0,0.5]} else {[0,0.7,0,0.5]});
_ctrlFOX ctrlSetBackgroundColor (if (_foxtrotLocked) then {[0.7,0,0,0.5]} else {[0,0.7,0,0.5]});
_ctrlHAW ctrlSetBackgroundColor (if (_hawkeyeLocked) then {[0.7,0,0,0.5]} else {[0,0.7,0,0.5]});
_ctrlDrone ctrlSetBackgroundColor (if (_droneLocked) then {[0.7,0,0,0.5]} else {[0,0.7,0,0.5]});
