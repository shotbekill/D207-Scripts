_box = "Box_IED_Exp_F" createVehicle position player;
clearItemCargoGlobal _box;
clearMagazineCargoGlobal _box;
clearBackpackCargoGlobal _box;
clearWeaponCargoGlobal _box;


_box addItemCargoGlobal ["APERSBoundingMine_Range_Mag", 8];
_box addItemCargoGlobal ["ClaymoreDirectionalMine_Remote_Mag", 8];
_box addItemCargoGlobal ["APERSMine_Range_Mag", 8];
_box addItemCargoGlobal ["APERSTripMine_Wire_Mag", 8];
_box addBackpackCargoGlobal ["B_Carryall_blk", 2];

systemChat "An AP-Mines crate was spawned near you.";