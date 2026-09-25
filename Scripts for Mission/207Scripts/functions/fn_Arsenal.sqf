params [["_boxPos", [], [[]]]];
if (_boxPos isEqualTo []) exitWith {};
private _arsenalBox = "B_supplyCrate_F" createVehicle _boxPos;
clearItemCargoGlobal _arsenalBox;
clearMagazineCargoGlobal _arsenalBox;
clearBackpackCargoGlobal _arsenalBox;
clearWeaponCargoGlobal _arsenalBox;
[_arsenalBox] remoteExec ["D207_fnc_Arsenalitems", -2, _arsenalBox];
