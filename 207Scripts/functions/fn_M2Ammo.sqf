_box = "Box_EAF_AmmoOrd_F" createVehicle position player;
clearItemCargoGlobal _box;
clearMagazineCargoGlobal _box;
clearBackpackCargoGlobal _box;
clearWeaponCargoGlobal _box;

_box addItemCargoGlobal ["ace_csw_100Rnd_127x99_mag", 5];

systemChat "A M2 ammo crate was spawned near you.";