MetisBox = "Box_NATO_WpsLaunch_F" createVehicle position player;
_box = MetisBox;
clearItemCargoGlobal _box;
clearMagazineCargoGlobal _box;
clearBackpackCargoGlobal _box;
clearWeaponCargoGlobal _box;

_box addItemCargoGlobal ["launch_O_Vorona_green_F", 2 ];
_box addItemCargoGlobal ["Vorona_HEAT", 10 ];
_box addItemCargoGlobal ["Vorona_HE", 5 ];