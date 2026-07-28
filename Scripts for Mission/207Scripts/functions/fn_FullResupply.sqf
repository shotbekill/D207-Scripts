params ["_BoxPos"];
hint "Making full resupply + Vehicle";
//_flatbed = "ADFRC_hemtt_flatbed" createVehicle _BoxPos;
_flatbed = "rhsusf_M1084A1R_SOV_M2_D_fmtv_socom" createVehicle _BoxPos;

_Tracks = "BL_Case_D207_Tracks" createVehicle _BoxPos;
[_flatbed,_Tracks] call boxloader_fnc_load;
_Wheels = "BL_Case_D207_Wheels" createVehicle _BoxPos;
[_flatbed,_Wheels] call boxloader_fnc_load;

_BaseboxBigpawn = [[_flatbed, "TOP"], "BL_Crate_D207_OpDem", 1, [0,5,0], (0),{0},false] call BIS_fnc_spawnObjects;
_BaseboxBig = _BaseboxBigpawn select 0;
[_BaseboxBig, 20] call ace_cargo_fnc_setSpace;
_Resupply1 = [_BaseboxBig] spawn D207_fnc_OpAlpha;
_Resupply2 = [_BaseboxBig] spawn D207_fnc_OpBravo;
_Resupply3 = [_BaseboxBig] spawn D207_fnc_OpCharlie;
_Resupply4 = [_BaseboxBig] spawn D207_fnc_OpReaper;
_Resupply5 = [_BaseboxBig] spawn D207_fnc_OpPHQ;
waitUntil {scriptDone _Resupply1};
waitUntil {scriptDone _Resupply2};
waitUntil {scriptDone _Resupply3};
waitUntil {scriptDone _Resupply4};
waitUntil {scriptDone _Resupply5};
_BaseboxBig allowDamage false;
_BaseboxBig enableSimulation true;
[_flatbed,_BaseboxBig] call boxloader_fnc_load;

_Ammobox = "Boxloader_SmallPallet_Ammo" createVehicle _BoxPos;
[_Ammobox, 5000] remoteExec ["ace_rearm_fnc_makeSource", 2];
[_Ammobox, 5000] remoteExec ["ace_rearm_fnc_setSupplyCount", 2];
_Ammobox setVariable ["ace_isRepairFacility", 1, true];
[_flatbed,_Ammobox] call boxloader_fnc_load;

_fueltank = "FlexibleTank_01_forest_F" createVehicle _BoxPos;
[_flatbed,_fueltank] call boxloader_fnc_load;
_fueltank = "FlexibleTank_01_forest_F" createVehicle _BoxPos;
[_flatbed,_fueltank] call boxloader_fnc_load;
_fueltank = "FlexibleTank_01_forest_F" createVehicle _BoxPos;
[_flatbed,_fueltank] call boxloader_fnc_load;

_palletjack = "boxloader_pallet_jack" createVehicle _BoxPos;
[_flatbed,_palletjack] call boxloader_fnc_load;
_palletjack = "boxloader_pallet_jack" createVehicle _BoxPos;
[_flatbed,_palletjack] call boxloader_fnc_load;
sleep 1;
hint "Full resupply is done";