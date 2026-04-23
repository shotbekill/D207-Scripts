params ["_BoxPos"];
_box = "Box_NATO_Wps_F" createVehicle _BoxPos;
clearItemCargoGlobal _box;
clearMagazineCargoGlobal _box;
clearBackpackCargoGlobal _box;
clearWeaponCargoGlobal _box;
_box addItemCargoGlobal ["ACE_key_lockpick", 50 ];
_box addItemCargoGlobal ["ACE_key_west", 50 ];