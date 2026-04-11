params ["_BaseboxBig"];
_Box1itemlist = [
	["DRNP_RD", 2 ],
	["tfw_rf3080Item", 2 ],
	["10Rnd_338_Mag", 10 ],
	["7Rnd_408_Mag", 10 ],
	["ACE_10Rnd_127x99_AMAX_Mag", 10 ],
	["ACE_20Rnd_762x51_M993_AP_Mag", 10 ],
	["ACE_HuntIR_M203", 10 ],
	["SmokeShellBlue", 6 ],
	["SmokeShellGreen", 6 ]
];
_Box2itemlist = [
	["SmokeShellBlue", 6]
];
_Box3itemlist = [
	["SmokeShellBlue", 6]
];
_Box4itemlist = [
	["SmokeShellBlue", 6]
];
_BoxOBJs = [];
_Baseboxspawn = [[_BaseboxBig, "TOP"], "BL_Case_D207_AMCU_G", 1, [0,3,0], (0),{0},false] call BIS_fnc_spawnObjects;
_Basebox = _Baseboxspawn select 0;
_box1spawn = [[_Basebox, "TOP"], "Box_NATO_Wps_F", 1, [1,0,0], (0),{0},false] call BIS_fnc_spawnObjects;
_box1 = _box1spawn select 0;
_BoxOBJs append [_box1];
_box2spawn = [[_Basebox, "TOP"], "Box_NATO_WpsSpecial_F", 1, [0,1,0], (0),{0},false] call BIS_fnc_spawnObjects;
_box2 = _box2spawn select 0;
_BoxOBJs append [_box2];
_box3spawn = [[_Basebox, "TOP"], "ADFRC_weaponbox_mg", 1, [-1,0,0], (0),{0},false] call BIS_fnc_spawnObjects;
_box3 = _box3spawn select 0;
_BoxOBJs append [_box3];
_box4spawn = [[_Basebox, "TOP"], "ADFRC_weaponbox_medium", 1, [0,-1,0], (0),{0},false] call BIS_fnc_spawnObjects;
_box4 = _box4spawn select 0;
_BoxOBJs append [_box4];
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
{
	_item = _x select 0;
	if (_item isKindOf ["Bag_Base", configfile >> "CfgVehicles"]) then {_box4 addBackpackCargoGlobal _x;} else {_box4 addItemCargoGlobal _x;};
	_item = [];
}foreach _Box4itemlist;
{
	_x enableSimulation true;
	[_x, _Basebox, true] call ace_cargo_fnc_loadItem;
}foreach _BoxOBJs;
_Basebox allowDamage false;
	_Basebox enableSimulation true;
	_Wheel = "UGV_02_Wheel_F" createVehicle position player;
	_Wheelpos = getPos _Wheel;
	deleteVehicle _Wheel;
	_Basebox setPos _Wheelpos;
	_Basebox allowDamage true;
	systemChat "Ghost Resupply has been made near you.";