params ["_BaseboxBig"]; //36 - 233 
_Box1itemlist = [
	["muzzle_snds_B", 10],
	["KAR_XM250_BLK", 2],
	["ADFRC_maximi_Modern", 2],
	["LMG_03_F", 2],
	["KAR_XM7_BLK", 2],
	["ADFRC_HK417_Black", 2],
	["SMA_ACRREMblk", 2],
	["SMA_supp2smaB_556", 2],
	["rhs_weap_M320", 2],
	["SMA_ELCAN_SPECTER_RDS_4z", 2],
	["SMA_ELCAN_SPECTER_ARDRDS_4z", 2],
	["SMA_eotechG33_3XDOWN", 2],
	["sma_spitfire_03_rds_low_black", 2],
	["ACE_optic_Hamr_2D", 2],
	["optic_AMS", 2],
	["ACE_Tripod", 5]
];
_Box2itemlist = [
	["ACE_ATragMX", 2],
	["ACE_Kestrel4500", 2],
	["ACE_HuntIR_M203", 3],
	["SmokeShellYellow", 10],
	["1Rnd_SmokeYellow_Grenade_shell", 10],
	["rhs_mag_M433_HEDP", 10],
	["rhs_mag_mk84", 10],
	["rhs_mag_m67", 10],
	["GX_1RND_DRONE40_RECON_M203", 5]
];
_Box3itemlist = [
	["launch_O_Titan_short_F", 1],
	["launch_MRAWS_green_F", 2],
	["KAR_100Rnd_Fury_RT_blk", 5],
	["ADFRC_150Rnd_762_Belt_TR5", 15],
	["KAR_20Rnd_Fury_RT_blk", 30],
	["SMA_30Rnd_68x43_SPC_FMJ", 20],
	["MAA_MAAWS_GMM_HEAT", 5],
	["MRAWS_HEAT55_F", 5],
	["MRAWS_HEAT_F", 15],
	["MAA_MAAWS_ASM509", 5],
	["MAA_MAAWS_GMM_MT", 5],
	["rhsusf_100Rnd_762x51_m61_ap", 10],
	["rhsusf_100Rnd_556x45_M995_soft_pouch", 10],
	["Titan_AT", 10],
	["Titan_AP", 10]
];
_BoxOBJs = [];
_boxtypeA = 0;
if (typeOf _BaseboxBig == "BL_Crate_D207_OpDem") then {_boxtypeA = 1;};
_boxspawn = [[_BaseboxBig, "TOP"], "BL_Case_D207_AMCU_R", 1, [0,-3,5], (0),{0},false] call BIS_fnc_spawnObjects;
_Basebox = _boxspawn select 0;
_boxtype = 1;
_box1spawn = [[_Basebox, "TOP"], "Box_NATO_Wps_F", 1, [1,0,0], (0),{0},false] call BIS_fnc_spawnObjects;
_box1 = _box1spawn select 0;
_BoxOBJs append [_box1];
_box2spawn = [[_Basebox, "TOP"], "Box_NATO_Ammo_F", 1, [0,1,0], (0),{0},false] call BIS_fnc_spawnObjects;
_box2 = _box2spawn select 0;
_BoxOBJs append [_box2];
_box3spawn = [[_Basebox, "TOP"], "Box_NATO_Equip_F", 1, [-1,0,0], (0),{0},false] call BIS_fnc_spawnObjects;
_box3 = _box3spawn select 0;
_BoxOBJs append [_box3];
{
	clearItemCargoGlobal _x;
	clearMagazineCargoGlobal _x;
	clearBackpackCargoGlobal _x;
	clearWeaponCargoGlobal _x;
}foreach _BoxOBJs;
_item = [];
{
	_item = _x select 0;
	if (_item isKindOf ["Bag_Base", configfile >> "CfgVehicles"]) then {_box1 addBackpackCargoGlobal _x;} else {_box1 addItemCargoGlobal _x;};
	_item = [];
}foreach _Box1itemlist;
{
	_item = _x select 0;
	if (_item isKindOf ["Bag_Base", configfile >> "CfgVehicles"]) then {_box2 addBackpackCargoGlobal _x;} else {_box2 addItemCargoGlobal _x;};
	_item = [];
}foreach _Box2itemlist;
{
	_item = _x select 0;
	if (_item isKindOf ["Bag_Base", configfile >> "CfgVehicles"]) then {_box3 addBackpackCargoGlobal _x;} else {_box3 addItemCargoGlobal _x;};
	_item = [];
}foreach _Box3itemlist;
_medbox = [_Basebox, _boxtype] spawn D207_fnc_Medic;
waitUntil {scriptDone _medbox};
sleep 1;
{
	_x enableSimulation true;
	[_x, _Basebox, true] call ace_cargo_fnc_loadItem;
}foreach _BoxOBJs;
if (_boxtypeA == 1) then {
	_Basebox enableSimulation true;
	[_Basebox, _BaseboxBig, true] call ace_cargo_fnc_loadItem;
} else {
	_Basebox allowDamage false;
	_Basebox enableSimulation true;
	_Wheel = "UGV_02_Wheel_F" createVehicle position player;
	_Wheelpos = getPos _Wheel;
	deleteVehicle _Wheel;
	_Basebox setPos _Wheelpos;
	_Basebox allowDamage true;
	systemChat "Reaper Resupply has been made near you.";
};