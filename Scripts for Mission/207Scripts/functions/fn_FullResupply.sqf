params ["_BoxPos"];
hint "Making full resupply + Vehicle";
_flatbed = "ADFRC_hemtt_flatbed" createVehicle _BoxPos;

for "_i" from 0 to 2 do {
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
};

_Ammobox = "Boxloader_SmallPallet_Ammo" createVehicle _BoxPos;
[_Ammobox, 5000] remoteExec ["ace_rearm_fnc_makeSource", 2];
[_Ammobox, 5000] remoteExec ["ace_rearm_fnc_setSupplyCount", 2];
_Ammobox setVariable ["ace_isRepairFacility", 1, true];
[_flatbed,_Ammobox] call boxloader_fnc_load;

_boxBig = "Land_Boxloader_Crate_1" createVehicle _BoxPos;
[_boxBig, 16] call ace_cargo_fnc_setSpace;
_boxname = "Land_Boxloader_Case_Tan" createVehicle _BoxPos;
[_boxname, 10] call ace_cargo_fnc_setSpace;
for "_x" from 0 to 9 do {
_wheel = "ACE_Wheel" createVehicle _BoxPos;
[_wheel, _boxname, true] call ace_cargo_fnc_loadItem;
};
[_boxname, _boxBig, true] call ace_cargo_fnc_loadItem;
[_boxBig] spawn D207_fnc_PlatHQfull;
[_boxBig] spawn D207_fnc_Ghost;
sleep 1;
[_flatbed,_boxBig] call boxloader_fnc_load;

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