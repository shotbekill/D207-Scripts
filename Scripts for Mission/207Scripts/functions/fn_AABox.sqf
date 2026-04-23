AABox = "Box_NATO_WpsLaunch_F" createVehicle position player;
_box = AABox;
clearItemCargoGlobal _box;
clearMagazineCargoGlobal _box;
clearBackpackCargoGlobal _box;
clearWeaponCargoGlobal _box;

_box addItemCargoGlobal ["Titan_AA", 15 ];