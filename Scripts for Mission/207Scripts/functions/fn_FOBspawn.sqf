params [["_boxPos", [], [[]]]];
if (_boxPos isEqualTo []) exitWith {};
private _box = "B_Slingload_01_Medevac_F" createVehicle _boxPos;
_box setVariable ["FOBSpawn", false, true];
[_box] remoteExec ["D207_fnc_teleFOB", -2, _box];
