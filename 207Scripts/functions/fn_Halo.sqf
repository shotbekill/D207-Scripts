_box = "Box_CSAT_Uniforms_F" createVehicle position player;
clearItemCargoGlobal _box;
clearMagazineCargoGlobal _box;
clearBackpackCargoGlobal _box;
clearWeaponCargoGlobal _box;


_box addBackpackCargoGlobal ["B_Parachute", 20];
_box addItemCargoGlobal ["ACE_Altimeter", 20];


systemChat "A HALO jump crate was spawned near you.";