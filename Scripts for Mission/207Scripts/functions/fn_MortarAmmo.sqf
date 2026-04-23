_box = "Box_IND_AmmoOrd_F" createVehicle position player;
clearItemCargoGlobal _box;
clearMagazineCargoGlobal _box;
clearBackpackCargoGlobal _box;
clearWeaponCargoGlobal _box;

_box addItemCargoGlobal ["ACE_1Rnd_82mm_Mo_HE", 30];
_box addItemCargoGlobal ["ACE_1Rnd_82mm_Mo_Smoke", 10];
_box addItemCargoGlobal ["ACE_1Rnd_82mm_Mo_HE_LaserGuided", 10];

systemChat "A mortar ammo crate was spawned near you.";