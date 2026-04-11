_box = "Box_NATO_AmmoOrd_F" createVehicle position player;
clearItemCargoGlobal _box;
clearMagazineCargoGlobal _box;
clearBackpackCargoGlobal _box;
clearWeaponCargoGlobal _box;


_box addItemCargoGlobal ["ace_compat_rhs_usf3_mag_TOW", 5];

systemChat "A TOW ammo crate was spawned near you.";