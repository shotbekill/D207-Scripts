params ["_BoxPos"];
_Arsenalbox = "B_supplyCrate_F" createVehicle _BoxPos;
clearItemCargoGlobal _Arsenalbox;
clearMagazineCargoGlobal _Arsenalbox;
clearBackpackCargoGlobal _Arsenalbox;
clearWeaponCargoGlobal _Arsenalbox;

[_Arsenalbox] remoteExec ["D207_fnc_Arsenalitems", 0];
//[_Arsenalbox] spawn D207_fnc_Arsenalitems;