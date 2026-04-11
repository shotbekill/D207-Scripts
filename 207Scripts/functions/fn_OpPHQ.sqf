params ["_BaseboxBig"]; //19 - 163
_Box1itemlist = [
	["SmokeShellYellow", 5 ],
	["SmokeShellGreen", 5 ],
	["SmokeShellBlue", 10 ],
	["1Rnd_SmokeRed_Grenade_shell", 5 ],
	["1Rnd_Smoke_Grenade_shell", 5 ],
	["ACE_HuntIR_M203", 10 ],
	["rhs_mag_M433_HEDP", 10 ],
	["SMA_20Rnd_762x51mm_M80A1_EPR_Tracer", 10 ],
	["SMA_30Rnd_68x43_SPC_FMJ", 10 ],
	["rhs_mag_30Rnd_556x45_M855_PMAG_Tracer_Red", 10 ],
	["20Rnd_mas_aus_762x51_Mag", 10 ],
	["rhs_weap_M136", 5],
	["rhs_weap_m72a7", 5 ],
	["KAR_20Rnd_Fury_GT_blk", 35 ]
];
_Box2itemlist = [
	["GX_UAVBattery", 5],
	["GX_DEPLOYABLE_MAGAZINE_RQ11B_UAV", 3],
	["GX_1RND_DRONE40_RECON_M203", 10],
	["rhs_weap_M136", 5],
	["rhs_weap_m72a7", 5]
];
_BoxOBJs = [];
_boxtypeA = 0;
if (typeOf _BaseboxBig == "BL_Crate_D207_OpDem") then {_boxtypeA = 1;};
_boxspawn = [[_BaseboxBig, "TOP"], "BL_Case_D207_AMCU_PHQ", 1, [0,0,5], (0),{0},false] call BIS_fnc_spawnObjects;
_Basebox = _boxspawn select 0;
_boxtype = 1;
_box1spawn = [[_Basebox, "TOP"], "Box_NATO_Wps_F", 1, [1,0,0], (0),{0},false] call BIS_fnc_spawnObjects;
_box1 = _box1spawn select 0;
_BoxOBJs append [_box1];
_box2spawn = [[_Basebox, "TOP"], "Box_NATO_Equip_F", 1, [0,1,0], (0),{0},false] call BIS_fnc_spawnObjects;
_box2 = _box2spawn select 0;
_BoxOBJs append [_box2];
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
_Medicbox = [_Basebox, _boxtype] spawn D207_fnc_Medic;
_Doctorbox = [_Basebox, _boxtype] spawn D207_fnc_Doctor;
waitUntil {scriptDone _Medicbox};
waitUntil {scriptDone _Doctorbox};
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
	systemChat "PlatHQ Resupply made and has been spawned near you.";
};