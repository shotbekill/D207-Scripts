private ["_box","_resup","_resup1","_resup2","_resup3","_resup4","_resup5","_resup6","_resup7","_Basefull","_Reaper","_Grenades","_Medic","_Doctor","_PlatHQ","_Boxloader","_Track","_Wheel","_palletjack","_Ammo","_Fuel","_AMR","_Snip","_M32","_AR2","_APMines","_ATMines","_NVG","_CBRN1","_CBRN2","_radio","_HALO","_SCUBA","_SAD","_Mort","_MortAmmo","_M2","_MAmmo","_TOW","_TowAmmo","_ber","_Arsenal"];
params ["_box"];
waitUntil {!isNil "Startup"};
if (hasInterface) then {
waitUntil {missionNamespace getVariable "Startup"};
_box spawn D207_fnc_Arsenalitems;

_D207 = ["D207", "<t color='#207207'>D207 Logistical</t>","",{nil}, {true}, {}, [], [0, 0, -1], 7] call ace_interact_menu_fnc_createAction;
[_box, 0, [], _D207]  call ace_interact_menu_fnc_addActionToObject;

_Arsenal = ["CoreArsenal", "<t color='#ff0000'>Arsenal</t>","",{[_target, player] call ace_arsenal_fnc_openBox;}, {true}] call ace_interact_menu_fnc_createAction;
[_box, 0, ["D207"], _Arsenal]  call ace_interact_menu_fnc_addActionToObject;

_Opdems = ["Core1", "<t color='#207207'>Opdems</t>","",{nil}, {true}] call ace_interact_menu_fnc_createAction;
[_box, 0, ["D207"], _Opdems]  call ace_interact_menu_fnc_addActionToObject;

_Basefull = ["BaseBox", "<t color='#207207'>Base Opdem</t>","",{[_target] spawn D207_fnc_Basefull;}, {true}] call ace_interact_menu_fnc_createAction;
[_box, 0, ["D207", "Core1"], _Basefull]  call ace_interact_menu_fnc_addActionToObject;

_SectionOpdems = ["Core11", "<t color='#725400'>Section Opdems</t>","",{nil}, {true}] call ace_interact_menu_fnc_createAction;
[_box, 0, ["D207", "Core1"], _SectionOpdems]  call ace_interact_menu_fnc_addActionToObject;

_Alpha = ["Alpha", "Alpha Box","",{[_target] spawn D207_fnc_OpAlpha;}, {true}] call ace_interact_menu_fnc_createAction;
[_box, 0, ["D207", "Core1", "Core11"], _Alpha]  call ace_interact_menu_fnc_addActionToObject;

_Bravo = ["Bravo", "Bravo Box","",{[_target] spawn D207_fnc_OpBravo;}, {true}] call ace_interact_menu_fnc_createAction;
[_box, 0, ["D207", "Core1", "Core11"], _Bravo]  call ace_interact_menu_fnc_addActionToObject;

_Charlie = ["Charlie", "Charlie Box","",{[_target] spawn D207_fnc_OpCharlie;}, {true}] call ace_interact_menu_fnc_createAction;
[_box, 0, ["D207", "Core1", "Core11"], _Charlie]  call ace_interact_menu_fnc_addActionToObject;

_Reaper = ["Reaper", "Reaper Box","",{[_target] spawn D207_fnc_OpReaper;}, {true}] call ace_interact_menu_fnc_createAction;
[_box, 0, ["D207", "Core1", "Core11"], _Reaper]  call ace_interact_menu_fnc_addActionToObject;

_PlatHQ = ["PlatHQ", "PHQ","",{[_target] spawn D207_fnc_OpPHQ;}, {true}] call ace_interact_menu_fnc_createAction;
[_box, 0, ["D207", "Core1", "Core11"], _PlatHQ]  call ace_interact_menu_fnc_addActionToObject;

_Ghost = ["Ghost", "Ghost","",{[_target] spawn D207_fnc_Ghost;}, {true}] call ace_interact_menu_fnc_createAction;
[_box, 0, ["D207", "Core1", "Core11"], _Ghost]  call ace_interact_menu_fnc_addActionToObject;

_SpecialOpdems = ["Core12", "<t color='#8d3a00'>Special Opdems</t>","",{nil}, {true}] call ace_interact_menu_fnc_createAction;
[_box, 0, ["D207", "Core1"], _SpecialOpdems]  call ace_interact_menu_fnc_addActionToObject;

_MedicalOpdems = ["Core121", "<t color='#800080'>Medical</t>","",{nil}, {true}] call ace_interact_menu_fnc_createAction;
[_box, 0, ["D207", "Core1", "Core12"], _MedicalOpdems]  call ace_interact_menu_fnc_addActionToObject;

_Medic = ["Medic", "Medic","",{[_target] spawn D207_fnc_Medic;}, {true}] call ace_interact_menu_fnc_createAction;
[_box, 0, ["D207", "Core1", "Core12", "Core121"], _Medic]  call ace_interact_menu_fnc_addActionToObject;

_Doctor = ["Doctor", "Doctor","",{[_target] spawn D207_fnc_Doctor;}, {true}] call ace_interact_menu_fnc_createAction;
[_box, 0, ["D207", "Core1", "Core12", "Core121"], _Doctor]  call ace_interact_menu_fnc_addActionToObject;

_SpecialExplosives = ["Core122", "<t color='#00FFF9'>Explosives</t>","",{nil}, {true}] call ace_interact_menu_fnc_createAction;
[_box, 0, ["D207", "Core1", "Core12"], _SpecialExplosives]  call ace_interact_menu_fnc_addActionToObject;

_Grenades = ["Grenades", "Grenades","",{player spawn D207_fnc_Grenades;}, {true}] call ace_interact_menu_fnc_createAction;
[_box, 0, ["D207", "Core1", "Core12", "Core122"], _Grenades]  call ace_interact_menu_fnc_addActionToObject;

_AAAmmo = ["AAAmmo", "AA Ammo","",{player spawn D207_fnc_AABox;}, {true}] call ace_interact_menu_fnc_createAction;
[_box, 0, ["D207", "Core1", "Core12", "Core122"], _AAAmmo]  call ace_interact_menu_fnc_addActionToObject;

_AR2 = ["demolitions", "Demolitions","",{player spawn D207_fnc_demolitions;}, {true}] call ace_interact_menu_fnc_createAction;
[_box, 0, ["D207", "Core1", "Core12", "Core122"], _AR2]  call ace_interact_menu_fnc_addActionToObject;

_APMines = ["APMines", "AP Mines","",{player spawn D207_fnc_APMines;}, {true}] call ace_interact_menu_fnc_createAction;
[_box, 0, ["D207", "Core1", "Core12", "Core122"], _APMines]  call ace_interact_menu_fnc_addActionToObject;

_ATMines = ["ATMines", "AT Mines","",{player spawn D207_fnc_ATMines;}, {true}] call ace_interact_menu_fnc_createAction;
[_box, 0, ["D207", "Core1", "Core12", "Core122"], _ATMines]  call ace_interact_menu_fnc_addActionToObject;

_SpecialGear = ["Core123", "<t color='#038F07'>Gear</t>","",{nil}, {true}] call ace_interact_menu_fnc_createAction;
[_box, 0, ["D207", "Core1", "Core12"], _SpecialGear]  call ace_interact_menu_fnc_addActionToObject;

_NVG = ["NVG", "NVGs and Radios","",{player spawn D207_fnc_NVG;}, {true}] call ace_interact_menu_fnc_createAction;
[_box, 0, ["D207", "Core1", "Core12", "Core123"], _NVG]  call ace_interact_menu_fnc_addActionToObject;

_CBRN2 = ["CBRN", "CBRN Gear","",{player spawn D207_fnc_CBRN;}, {true}] call ace_interact_menu_fnc_createAction;
[_box, 0, ["D207", "Core1", "Core12", "Core123"], _CBRN2]  call ace_interact_menu_fnc_addActionToObject;

_HALO = ["HALO", "HALO","",{player spawn D207_fnc_HALO;}, {true}] call ace_interact_menu_fnc_createAction;
[_box, 0, ["D207", "Core1", "Core12", "Core123"], _HALO]  call ace_interact_menu_fnc_addActionToObject;

_SpecialDrone = ["Core124", "<t color='#DCED40'>Drone's</t>","",{nil}, {true}] call ace_interact_menu_fnc_createAction;
[_box, 0, ["D207", "Core1", "Core12"], _SpecialDrone]  call ace_interact_menu_fnc_addActionToObject;

_HALO = ["Drone1", "Recon 40mm Drone's","",{[_target] spawn D207_fnc_DroneRecon;}, {true}] call ace_interact_menu_fnc_createAction;
[_box, 0, ["D207", "Core1", "Core12", "Core124"], _HALO]  call ace_interact_menu_fnc_addActionToObject;

_HALO = ["Drone2", "Recon Drone's","",{[_target] spawn D207_fnc_DroneRecon2;}, {true}] call ace_interact_menu_fnc_createAction;
[_box, 0, ["D207", "Core1", "Core12", "Core124"], _HALO]  call ace_interact_menu_fnc_addActionToObject;

_HALO = ["Drone3", "RQ11B Drone's","",{[_target] spawn D207_fnc_DroneRQ11B;}, {true}] call ace_interact_menu_fnc_createAction;
[_box, 0, ["D207", "Core1", "Core12", "Core124"], _HALO]  call ace_interact_menu_fnc_addActionToObject;

_HALO = ["Drone4", "Armed Drone's","",{[_target] spawn D207_fnc_DroneArm;}, {true}] call ace_interact_menu_fnc_createAction;
[_box, 0, ["D207", "Core1", "Core12", "Core124"], _HALO]  call ace_interact_menu_fnc_addActionToObject;

_Logistical = ["Core2", "<t color='#800080'>Logistical Stuff</t>","",{nil}, {true}] call ace_interact_menu_fnc_createAction;
[_box, 0, ["D207"], _Logistical]  call ace_interact_menu_fnc_addActionToObject;

_MainBox = ["Core21", "<t color='#725400'>Main Box's</t>","",{nil}, {true}] call ace_interact_menu_fnc_createAction;
[_box, 0, ["D207", "Core2"], _MainBox]  call ace_interact_menu_fnc_addActionToObject;

_palletjack = ["Palletjack", "Pallet Jack","",{"boxloader_pallet_jack" createVehicle position player;}, {true}] call ace_interact_menu_fnc_createAction;
[_box, 0, ["D207", "Core2", "Core21"], _palletjack]  call ace_interact_menu_fnc_addActionToObject;

_Ammo = ["Ammo", "Ammo Box","",{player spawn D207_fnc_Ammo;}, {true}] call ace_interact_menu_fnc_createAction;
[_box, 0, ["D207", "Core2", "Core21"], _Ammo]  call ace_interact_menu_fnc_addActionToObject;

_Fuel = ["Fuel", "Small Fuel Tank","",{player spawn D207_fnc_FuelS;}, {true}] call ace_interact_menu_fnc_createAction;
[_box, 0, ["D207", "Core2", "Core21"], _Fuel]  call ace_interact_menu_fnc_addActionToObject;

_Boxloader = ["Boxloader", "Box Loader Crate","",{player spawn D207_fnc_BoxloaderCrate;}, {true}] call ace_interact_menu_fnc_createAction;
[_box, 0, ["D207", "Core2", "Core21"], _Boxloader]  call ace_interact_menu_fnc_addActionToObject;

_OtherBox = ["Core22", "<t color='#00FFF9'>Other Box's</t>","",{nil}, {true}] call ace_interact_menu_fnc_createAction;
[_box, 0, ["D207", "Core2"], _OtherBox]  call ace_interact_menu_fnc_addActionToObject;

_VParts = ["VParts", "Box of Vehicle Parts","",{"BL_Crate_D207_VParts" createVehicle position player;}, {true}] call ace_interact_menu_fnc_createAction;
[_box, 0, ["D207", "Core2", "Core22"], _VParts]  call ace_interact_menu_fnc_addActionToObject;

_Track = ["Track", "Box of Tracks","",{"BL_Case_D207_Tracks" createVehicle position player;}, {true}] call ace_interact_menu_fnc_createAction;
[_box, 0, ["D207", "Core2", "Core22"], _Track]  call ace_interact_menu_fnc_addActionToObject;

_Wheel = ["Wheel", "Box of Wheels","",{"BL_Case_D207_Wheels" createVehicle position player;}, {true}] call ace_interact_menu_fnc_createAction;
[_box, 0, ["D207", "Core2", "Core22"], _Wheel]  call ace_interact_menu_fnc_addActionToObject;

_Fuel = ["Fuel", "Big Fuel Tank","",{player spawn D207_fnc_FuelL;}, {true}] call ace_interact_menu_fnc_createAction;
[_box, 0, ["D207", "Core2", "Core22"], _Fuel]  call ace_interact_menu_fnc_addActionToObject;

_Vicmover = ["Vicmover", "Vehicle Packer","",{_packerbox = "BL_Crate_D207_VPacker" createVehicle position player;[_packerbox] remoteExec ["D207_fnc_vicmovemake", 0];}, {true}] call ace_interact_menu_fnc_createAction;
[_box, 0, ["D207", "Core2", "Core22"], _Vicmover]  call ace_interact_menu_fnc_addActionToObject;

_Statics = ["Core23", "<t color='#8d3a00'>Statics</t>","",{nil}, {true}] call ace_interact_menu_fnc_createAction;
[_box, 0, ["D207", "Core2"], _Statics]  call ace_interact_menu_fnc_addActionToObject;

_Metis = ["Metis", "Metis launcher","",{player spawn D207_fnc_MetisBox;}, {true}] call ace_interact_menu_fnc_createAction;
[_box, 0, ["D207", "Core2", "Core23"], _Metis]  call ace_interact_menu_fnc_addActionToObject;

_Mort = ["Mortar", "Mortar","",{player spawn D207_fnc_mortar;}, {true}] call ace_interact_menu_fnc_createAction;
[_box, 0, ["D207", "Core2", "Core23"], _Mort]  call ace_interact_menu_fnc_addActionToObject;

_MortAmmo = ["Mortarammo", "Mortar Ammo","",{player spawn D207_fnc_mortarammo;}, {true}] call ace_interact_menu_fnc_createAction;
[_box, 0, ["D207", "Core2", "Core23"], _MortAmmo]  call ace_interact_menu_fnc_addActionToObject;

_M2 = ["M2", "M2","",{player spawn D207_fnc_M2;}, {true}] call ace_interact_menu_fnc_createAction;
[_box, 0, ["D207", "Core2", "Core23"], _M2]  call ace_interact_menu_fnc_addActionToObject;

_MAmmo = ["M2Ammo", "M2 Ammo","",{player spawn D207_fnc_M2ammo;}, {true}] call ace_interact_menu_fnc_createAction;
[_box, 0, ["D207", "Core2", "Core23"], _MAmmo]  call ace_interact_menu_fnc_addActionToObject;

_TOW = ["TOW", "TOW","",{player spawn D207_fnc_TOW;}, {true}] call ace_interact_menu_fnc_createAction;
[_box, 0, ["D207", "Core2", "Core23"], _TOW]  call ace_interact_menu_fnc_addActionToObject;

_TowAmmo = ["TowAmmo", "TOW Ammo","",{player spawn D207_fnc_towammo;}, {true}] call ace_interact_menu_fnc_createAction;
[_box, 0, ["D207", "Core2", "Core23"], _TowAmmo]  call ace_interact_menu_fnc_addActionToObject;

_StaticsBox = ["StaticsBox", "Statics Box","",{_mainbox = "BL_Crate_D207_Statics" createVehicle position player;[_mainbox] remoteExec ["D207_fnc_StaticsBox", 0];}, {true}] call ace_interact_menu_fnc_createAction;
[_box, 0, ["D207", "Core2", "Core23"], _StaticsBox]  call ace_interact_menu_fnc_addActionToObject;

_VehicleSpawner = ["VehicleSpawner", "<t color='#DCED40'>Vehicle Spawner</t>","",{[_target] execVM "207Scripts\Vehiclespawner\StartDialog.sqf"}, {true}] call ace_interact_menu_fnc_createAction;
[_box, 0, ["D207", "Core2"], _VehicleSpawner]  call ace_interact_menu_fnc_addActionToObject;

_PackBox = ["PackBox", "<t color='#013DB7'>Pack Logistical Box</t>","",{[_target] spawn D207_fnc_MoveLogisticalBox;}, {true}] call ace_interact_menu_fnc_createAction;
[_box, 0, ["D207"], _PackBox]  call ace_interact_menu_fnc_addActionToObject;
};