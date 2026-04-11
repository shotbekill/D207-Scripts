params ["_Basebox", "_boxtype"];
if (isNil "_boxtype") then {_boxtype = 0;};
_boxspawn = [[_Basebox, "TOP"], "ACE_medicalSupplyCrate", 1, [0,-1,0], (0),{0},false] call BIS_fnc_spawnObjects;
_box = _boxspawn select 0;
clearItemCargoGlobal _box;
clearMagazineCargoGlobal _box;
clearBackpackCargoGlobal _box;
clearWeaponCargoGlobal _box;
_box addItemCargoGlobal ["ACE_elasticBandage", 80];
_box addItemCargoGlobal ["ACE_packingBandage", 80];
_box addItemCargoGlobal ["ACE_quikclot", 40];
_box addItemCargoGlobal ["ACE_tourniquet", 10];
_box addItemCargoGlobal ["ACE_splint", 20];
_box addItemCargoGlobal ["kat_Pulseoximeter", 10];
_box addItemCargoGlobal ["kat_larynx", 20]; //King LT
_box addItemCargoGlobal ["kat_stethoscope", 1];
_box addItemCargoGlobal ["kat_chestSeal", 15];
_box addItemCargoGlobal ["kat_IV_16", 30];
_box addItemCargoGlobal ["kat_IO_fast", 20];
_box addItemCargoGlobal ["ACE_bloodIV", 10];
_box addItemCargoGlobal ["ACE_bloodIV_250", 15];
_box addItemCargoGlobal ["ACE_bloodIV_500", 15];
_box addItemCargoGlobal ["kat_painkiller", 10];
_box addItemCargoGlobal ["ACE_epinephrine", 15];
_box addItemCargoGlobal ["kat_Atropine", 20];
_box addItemCargoGlobal ["kat_naloxone", 10];
_box addItemCargoGlobal ["kat_Norepinephrine", 5];
_box addItemCargoGlobal ["kat_Carbonate", 4];
_box addItemCargoGlobal ["ACE_morphine", 5];
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