_box = "Box_IED_Exp_F" createVehicle position player;
clearItemCargoGlobal _box;
clearMagazineCargoGlobal _box;
clearBackpackCargoGlobal _box;
clearWeaponCargoGlobal _box;


_box addItemCargoGlobal ["DemoCharge_Remote_Mag", 10];
_box addItemCargoGlobal ["SatchelCharge_Remote_Mag", 10];
_box addBackpackCargoGlobal ["B_Carryall_blk", 2];

systemChat "An demolitions crate was spawned near you.";