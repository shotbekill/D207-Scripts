private _ammoBox = "Boxloader_SmallPallet_Ammo" createVehicle position player;
[_ammoBox, 5000] remoteExec ["ace_rearm_fnc_makeSource", 2];
[_ammoBox, 5000] remoteExec ["ace_rearm_fnc_setSupplyCount", 2];
_ammoBox setVariable ["ace_isRepairFacility", 1, true];
