params [
    ["_endExPos", [], [[]]],
    ["_caller", objNull, [objNull]]
];
if (_endExPos isEqualTo []) exitWith {};

if (!isServer) exitWith {[_endExPos, player] remoteExecCall ["D207_fnc_EndExPos", 2];};
if (isRemoteExecuted && {isNull _caller || {!isPlayer _caller}}) exitWith {};
if (isRemoteExecuted && {remoteExecutedOwner != owner _caller}) exitWith {};
if (isRemoteExecuted && {isNull (getAssignedCuratorLogic _caller)}) exitWith {};

missionNamespace setVariable ["EndExPos", _endExPos, true];
private _flagPos1 = [(_endExPos select 0) + 20, _endExPos select 1, _endExPos select 2];
private _flagPos2 = [(_endExPos select 0) - 20, _endExPos select 1, _endExPos select 2];
"FLAG_adfrc_F" createVehicle _flagPos1;
"FLAG_adfrc_F" createVehicle _flagPos2;
private _boxPos1 = [(_endExPos select 0) + 5, (_endExPos select 1) + 2, _endExPos select 2];
private _boxPos2 = [(_endExPos select 0) - 5, (_endExPos select 1) + 2, _endExPos select 2];
private _box1 = "C_IDAP_supplyCrate_F" createVehicle _boxPos1;
private _box2 = "C_IDAP_supplyCrate_F" createVehicle _boxPos2;

{
    clearItemCargoGlobal _x;
    clearMagazineCargoGlobal _x;
    clearBackpackCargoGlobal _x;
    clearWeaponCargoGlobal _x;
    _x addItemCargoGlobal ["J_207_Beret", 60];
    _x addItemCargoGlobal ["O_207_Beret", 60];
    _x addItemCargoGlobal ["V_207_Beret", 60];
} forEach [_box1, _box2];

if (markerType "EndEx" isNotEqualTo "") then {deleteMarker "EndEx";};
private _endExMarker = createMarker ["EndEx", _endExPos];
_endExMarker setMarkerType "mil_flag";
_endExMarker setMarkerText "EndEx LOC";
_endExMarker setMarkerColor "#(0.1255,0.4471,0.0275)";

missionNamespace setVariable ["EndEx", true, true];
missionNamespace setVariable ["EndOp", true, true];
[] remoteExec ["D207_fnc_EndEx", -2];
