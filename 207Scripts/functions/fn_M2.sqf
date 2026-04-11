_box = "Box_EAF_WpsSpecial_F" createVehicle position player;
clearItemCargoGlobal _box;
clearMagazineCargoGlobal _box;
clearBackpackCargoGlobal _box;
clearWeaponCargoGlobal _box;

_box addItemCargoGlobal ["ace_csw_staticM2ShieldCarry", 1];
_box addItemCargoGlobal ["ace_csw_m3CarryTripod", 1];
_box addItemCargoGlobal ["ace_csw_100Rnd_127x99_mag", 2];


systemChat "A M2 crate was spawned near you.";