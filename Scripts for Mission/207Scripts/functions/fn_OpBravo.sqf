params ["_BaseboxBig"]; //26 - 378
_Box1itemlist = [
	["SMA_30Rnd_68x43_SPC_FMJ", 30],
	["KAR_20Rnd_Fury", 20],
	["SMA_30Rnd_68x43_sub", 15],
	["ACE_30Rnd_556x45_Stanag_M995_AP_mag", 30],
	["ACE_20Rnd_762x51_Mag_Tracer_Dim", 5],
	["ACE_20Rnd_762x51_M993_AP_Mag", 15],
	["ACE_20Rnd_762x51_Mk319_Mod_0_Mag", 15],
	["SMA_30Rnd_68x43_BT", 20]
];
_Box2itemlist = [
	["ACE_Banana", 10],
	["prpl_8Rnd_12Gauge_Pellets", 10],
	["ACE_HuntIR_M203", 15],
	["SmokeShellBlue", 5],
	["SmokeShellGreen", 5],
	["SmokeShellYellow", 20],
	["rhs_mag_M397_HET", 40],
	["rhs_mag_M433_HEDP", 20],
	["rhs_mag_m713_Red", 8],
	["rhs_mag_m716_yellow", 20]
];
_Box3itemlist = [
	["GX_1RND_DRONE40_RECON_M203", 5],
	["KAR_100Rnd_Fury_YT", 20],
	["ACE_IR_Strobe_Item", 10],
	["DemoCharge_Remote_Mag", 10],
	["SatchelCharge_Remote_Mag", 5],
	["HandGrenade", 15],
	["rhs_mag_mk84", 20],
	["rhs_mag_smaw_HEDP", 2],
	["rhs_mag_smaw_HEAA", 2],
	["rhs_weap_M136", 5],
	["rhs_weap_m72a7", 5]
];
_BoxOBJs = [];
_boxtypeA = 0;
if (typeOf _BaseboxBig == "BL_Crate_D207_OpDem") then {_boxtypeA = 1;};
_boxspawn = [[_BaseboxBig, "TOP"], "BL_Case_D207_AMCU_B", 1, [0,3,5], (0),{0},false] call BIS_fnc_spawnObjects;
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
	systemChat "Bravo Resupply has been made near you.";
};