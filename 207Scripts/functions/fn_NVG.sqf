_box = "Box_NATO_Equip_F" createVehicle position player;
clearItemCargoGlobal _box;
clearMagazineCargoGlobal _box;
clearBackpackCargoGlobal _box;
clearWeaponCargoGlobal _box;


_box addItemCargoGlobal ["ACE_NVG_Wide", 60];
_box addItemCargoGlobal ["TFAR_anprc152", 60];
_box addBackpackCargoGlobal ["tfw_ilbe_whip_mc", 30];


systemChat "A crate of NVGs and Radios was spawned near you.";