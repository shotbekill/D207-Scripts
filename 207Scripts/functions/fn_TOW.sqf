_box = "Box_NATO_WpsSpecial_F" createVehicle position player;
clearItemCargoGlobal _box;
clearMagazineCargoGlobal _box;
clearBackpackCargoGlobal _box;
clearWeaponCargoGlobal _box;

_box addBackpackCargoGlobal ["rhs_Tow_Gun_Bag", 1];
_box addBackpackCargoGlobal ["rhs_Tow_Tripod_Bag", 1];
_box addItemCargoGlobal ["ace_compat_rhs_usf3_mag_TOW", 3];

systemChat "A TOW crate was spawned near you.";