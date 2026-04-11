_box = "Box_IND_WpsSpecial_F" createVehicle position player;
clearItemCargoGlobal _box;
clearMagazineCargoGlobal _box;
clearBackpackCargoGlobal _box;
clearWeaponCargoGlobal _box;

_box addBackpackCargoGlobal ["B_Mortar_01_weapon_F", 3];
_box addBackpackCargoGlobal ["B_Mortar_01_support_F", 3];

systemChat "A mortar crate was spawned near you.";