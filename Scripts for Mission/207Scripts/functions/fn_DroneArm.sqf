params ["_Basebox"];
_boxtype = 0;
if (typeOf _Basebox == "BL_Crate_D207_OpDem") then {_boxtype = 1;};
_boxspawn = [[_Basebox, "TOP"], "ADFRC_weaponbox_medium", 1, [0,-1,0], (0),{0},false] call BIS_fnc_spawnObjects;
_box = _boxspawn select 0;
_box addItemCargoGlobal ["GX_DEPLOYABLE_MAGAZINE_HONEYBADGER_UGV_AT_BLACK", 20];
_box addItemCargoGlobal ["GX_DEPLOYABLE_MAGAZINE_HMG_01", 10];
sleep 1;
_box enableSimulation true;
if (_boxtype == 1) then {
	[_box, _Basebox, true] call ace_cargo_fnc_loadItem;
} else {
	_Wheel = "UGV_02_Wheel_F" createVehicle position player;
	_Wheelpos = getPos _Wheel;
	deleteVehicle _Wheel;
	_box setPos _Wheelpos;
};