_box = "Box_IED_Exp_F" createVehicle position player;
clearItemCargoGlobal _box;
clearMagazineCargoGlobal _box;
clearBackpackCargoGlobal _box;
clearWeaponCargoGlobal _box;


_box addItemCargoGlobal ["ATMine_Range_Mag", 8];
_box addItemCargoGlobal ["SLAMDirectionalMine_Wire_Mag", 10];
_box addBackpackCargoGlobal ["B_Carryall_blk", 2];

systemChat "A AT-Mines crate was spawned near you.";