params ["_BaseboxBig"]; //47 - 585
_Box1itemlist = [
	["KAR_20Rnd_Fury_blk", 50],
	["ACE_30Rnd_556x45_Stanag_M995_AP_mag", 50],
	["SMA_30Rnd_68x43_BT", 50]
];
_Box2itemlist = [
	["SmokeShellBlue", 10],
	["SmokeShellGreen", 20],
	["SmokeShellYellow", 20],
	["rhs_mag_m713_Red", 10],
 	["rhs_mag_m716_yellow", 10],
	["rhs_mag_mk84", 20],
	["HandGrenade", 20],
	["rhsusf_m112_mag", 20],
	["ClaymoreDirectionalMine_Remote_Mag", 10]
];
_Box3itemlist = [
	["KAR_100Rnd_Fury", 10],
	["ADFRC_250Rnd_556_Minimi_TR", 10],
	["prpl_8Rnd_12Gauge_Pellets", 10],
	["ACE_HuntIR_M203", 15],
	["ACE_IR_Strobe_Item", 10],
	["rhs_mag_M433_HEDP", 40],
	["rhs_mag_M397_HET", 40],
	["ItemAndroid", 3],
	["ACE_VMH3", 1],
	["ACE_CableTie", 20],
	["ace_marker_flags_green", 10],
	["ace_marker_flags_red", 10],
 	["tfw_rf3080Item", 1],
 	["ACE_SpraypaintGreen", 10],
 	["ACE_DefusalKit", 1],
 	["ACE_EntrenchingTool", 10],
 	["ACE_Tripod", 10],
 	["ACE_wirecutter", 2],
	["ACE_EarPlugs", 1],
	["ACE_EHP", 10],
	["ACE_IR_Strobe_Item", 1],
	["kat_gasmaskFilter", 10],
	["ACE_MapTools", 3],
	["rhsusf_mag_17Rnd_9x19_FMJ", 20],
	["rhsusf_mag_40Rnd_46x30_AP", 5],
	["Laserdesignator", 2],
	["Laserbatteries", 2],
	["ItemcTab", 3],
	["ACE_HuntIR_monitor", 2],
	["rhs_weap_M136", 8],
	["rhs_weap_M320", 2],
	["MineDetector", 2],
	["rhs_mag_smaw_HEDP", 10],
	["rhsusf_weap_MP7A2_folded", 1]
];
_BoxOBJs = [];
_boxtypeA = 0;
if (typeOf _BaseboxBig == "BL_Crate_D207_OpDem") then {_boxtypeA = 1;};
_boxspawn = [[_BaseboxBig, "TOP"], "BL_Case_D207_AMCU_C", 1, [-3,0,5], (0),{0},false] call BIS_fnc_spawnObjects;
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
	systemChat "Charlie Resupply has been made near you.";
};