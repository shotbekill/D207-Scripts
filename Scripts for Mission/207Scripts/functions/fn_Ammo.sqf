AmmoBox = "Boxloader_SmallPallet_Ammo" createVehicle position player;
_Ammobox = AmmoBox;
[_Ammobox, 5000] remoteExec ["ace_rearm_fnc_makeSource", 2];
[_Ammobox, 5000] remoteExec ["ace_rearm_fnc_setSupplyCount", 2];
_Ammobox setVariable ["ace_isRepairFacility", 1, true];