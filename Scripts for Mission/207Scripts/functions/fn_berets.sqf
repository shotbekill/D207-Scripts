params ["_BoxPos"];
_box = "C_IDAP_supplyCrate_F" createVehicle _BoxPos;
clearItemCargoGlobal _box;
clearMagazineCargoGlobal _box;
clearBackpackCargoGlobal _box;
clearWeaponCargoGlobal _box;

_box addItemCargoGlobal ["J_207_Beret", 60];
_box addItemCargoGlobal ["O_207_Beret", 60];
_box addItemCargoGlobal ["V_207_Beret", 60];