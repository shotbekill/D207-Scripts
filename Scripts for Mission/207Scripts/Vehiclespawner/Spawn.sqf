closeDialog 1;
_ctrl = (findDisplay 8100) displayCtrl 1500;
_index = lbCurSel 1500;
_info = _ctrl lbData _index;
if (_info in D207_VehicleListPlatoon && D207_VehiclePlatoon) exitWith {hint "You can not spawn Platoon Vehicles. Ping a Zeus";};
if (_info in D207_VehicleListFoxtrot && D207_VehicleFoxtrot) exitWith {hint "You can not spawn Foxtrot Vehicles. Ping a Zeus";};
if (_info in D207_VehicleListHawkeye && D207_VehicleHawkeye) exitWith {hint "You can not spawn Hawkeye Vehicles. Ping a Zeus";};
if (_info in D207_VehicleListDrone && D207_VehicleDrone) exitWith {hint "You can not spawn Drone's at this time. Ping a Zeus";};
_Checkspawn = [[SpawnBoxLOC, "TOP"], "ACE_Wheel", 1, [0,20,0], (0),{0},false] call BIS_fnc_spawnObjects;
_CheckspawnLOC = _Checkspawn select 0;
_position = getPos _CheckspawnLOC;
deleteVehicle _CheckspawnLOC;
_spCheck = nearestObjects [_position,["landVehicle","Air"],10];
if(!isNil "_spCheck") then {
	{
		deleteVehicle _x;
	} forEach _spCheck;
	sleep 0.5;
};
_Vehicle = _info createVehicle _position;
if (unitIsUAV _Vehicle) then {
	_playerSide = playerSide;
	_group = createGroup _playerSide;
	_VehicleGroup = createVehicleCrew _Vehicle;
	_VehicleUnits = Units _VehicleGroup;
	_VehicleUnits joinSilent _group;
};
sleep 0.5;
clearWeaponCargoGlobal _vehicle;
clearMagazineCargoGlobal _vehicle;
clearItemCargoGlobal _vehicle;
clearBackpackCargoGlobal _vehicle;
if (_vehicle isKindOf "vtx_H60_base") then {
	_vehicle setObjectTextureGlobal [16, "asd207_hawkeye_textures\data\textures\d207_australia\asd207_main_co.paa"];
	_vehicle setObjectTextureGlobal [17, "asd207_hawkeye_textures\data\textures\d207_australia\asd207_misc_co.paa"];
	_vehicle setObjectTextureGlobal [18, "asd207_hawkeye_textures\data\textures\d207_australia\asd207_tail_co.paa"];
	_vehicle setObjectTextureGlobal [19, "hue_additions_h60-skins-and-markings\markings\207.paa"];
};
sleep 0.5;
_displayName = getText (configFile >>  "CfgVehicles" >> _info >> "displayName");
_chat = format ["You have spawned a %1", _displayName];
systemChat _chat;