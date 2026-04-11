
player addEventHandler ["Killed", { player setVariable ["SBK_DeathLoadout", getUnitLoadout player]; }];
player addEventHandler ["Respawn", { private _loadout = player getVariable "SBK_DeathLoadout"; if (!isNil "_loadout") then { player setUnitLoadout _loadout; }; player enableStamina false;}];

addMissionEventHandler ["EntityCreated", {
	params ["_entity"];
	if (unitIsUAV _entity) then {
	if (isNil "D207UAVCHECKVEH") then {D207UAVCHECKVEH = 1;} else {D207UAVCHECKVEH = D207UAVCHECKVEH + 1;};
	publicVariable "D207UAVCHECKVEH";
	_D207UAVCHECKVEH = D207UAVCHECKVEH;
	_D207UAVCHECKTFadd = _D207UAVCHECKVEH;
	_D207UAVCHECKTF = format ["D207UAVCHECKTF_%1",_D207UAVCHECKTFadd];
	missionNamespace setVariable [_D207UAVCHECKTF, false, true];
	[[_entity,_D207UAVCHECKTF]] remoteExec ["D207_fnc_NameUAV", -2];
	};
}];

[["LandVehicle"], ["Convoy Net","Air Net","HQ Net","Medic Net"]] call mor_fnc_vehicleSatCom;
[["Air"], ["Convoy Net","Air Net","HQ Net","Medic Net"]] call mor_fnc_vehicleSatCom;

["207 Modules", "Load In", {missionNamespace setVariable ["LoadIn", true, true];}] call zen_custom_modules_fnc_register;
["207 Modules", "Game on", {missionNamespace setVariable ["Gameon", true, true];}] call zen_custom_modules_fnc_register;
["207 Modules", "Game Stop", {missionNamespace setVariable ["GameStop", true, true];}] call zen_custom_modules_fnc_register;
["207 Modules", "endex", {[_this select 0] call D207_fnc_EndExPos;}] call zen_custom_modules_fnc_register;
["207 Modules", "Add J5 Spectator", {_this select 1 addEventHandler ["Respawn", {remoteExec ["D207_fnc_Spectator", _this select 1];}];remoteExec ["D207_fnc_Spectator",_this select 1];}] call zen_custom_modules_fnc_register;
["207 Modules", "Spawn Logi Box", {_Box = "B_Slingload_01_Cargo_F" createVehicle (_this select 0);[_Box] spawn D207_fnc_MoveLogisticalBox;}] call zen_custom_modules_fnc_register;
["207 Modules", "End Op", {if (EndEx) then {remoteExec ["D207_fnc_EndOp", 2];} else {hint "End Op not called"};}] call zen_custom_modules_fnc_register;
["207 Logistical", "Berets", {[_this select 0] call D207_fnc_berets;}] call zen_custom_modules_fnc_register;
["207 Logistical", "Arsenal", {[_this select 0] call D207_fnc_Arsenal;}] call zen_custom_modules_fnc_register;
["207 Logistical", "Respawn Mover", {[_this select 0] call D207_fnc_Makerespawn;}] call zen_custom_modules_fnc_register;
["207 Logistical", "Full Resupply Vehicle", {[_this select 0] Spawn D207_fnc_FullResupply;}] call zen_custom_modules_fnc_register;
["207 Logistical", "Box of Keys", {[_this select 0] call D207_fnc_Keys;}] call zen_custom_modules_fnc_register;
["207 Logistical", "Check Scripts", {[_this select 0] call D207_fnc_Checkmission;}] call zen_custom_modules_fnc_register;

["207 Vehicle Spawner", "Can Spawn Vehicle", {createDialog "CanSpawnVehicle";D207_CanSpawnCode = 0; D207_CanSpawnBool = 0; execVM '207Scripts\Vehiclespawner\CanSpawnCode.sqf';}] call zen_custom_modules_fnc_register;
["207 Vehicle Spawner", "Add Vehicle To Platoon Spawner", {
_Vehtoadd = _this select 1;
_Vehtoaddtpye = typeOf _Vehtoadd;
if (_Vehtoaddtpye in D207_VehicleListPlatoon) exitWith {hint "Vehicle is in the Spawner already";};
D207_VehicleListPlatoon append [_Vehtoaddtpye];
publicVariable "D207_VehicleListPlatoon";
_hinttext = parseText format ["%1 Added to the Platoon Vehicle Spawner", _Vehtoaddtpye];
hint _hinttext;
}] call zen_custom_modules_fnc_register;

["207 Vehicle Spawner", "Add Vehicle To Foxtrot Spawner", {
_Vehtoadd = _this select 1;
_Vehtoaddtpye = typeOf _Vehtoadd;
if (_Vehtoaddtpye in D207_VehicleListFoxtrot) exitWith {hint "Vehicle is in the Spawner already";};
D207_VehicleListFoxtrot append [_Vehtoaddtpye];
publicVariable "D207_VehicleListFoxtrot";
_hinttext = parseText format ["%1 Added to the Foxtrot Vehicle Spawner", _Vehtoaddtpye];
hint _hinttext;
}] call zen_custom_modules_fnc_register;

["207 Vehicle Spawner", "Add Vehicle To Hawkeye Spawner", {
_Vehtoadd = _this select 1;
_Vehtoaddtpye = typeOf _Vehtoadd;
if (_Vehtoaddtpye in D207_VehicleListHawkeye) exitWith {hint "Vehicle is in the Spawner already";};
D207_VehicleListHawkeye append [_Vehtoaddtpye];
publicVariable "D207_VehicleListHawkeye";
_hinttext = parseText format ["%1 Added to the Hawkeye Vehicle Spawner", _Vehtoaddtpye];
hint _hinttext;
}] call zen_custom_modules_fnc_register;

["207 Vehicle Spawner", "Add Vehicle To Drone Spawner", {
_Vehtoadd = _this select 1;
_Vehtoaddtpye = typeOf _Vehtoadd;
if (_Vehtoaddtpye in D207_VehicleListDrone) exitWith {hint "Vehicle is in the Spawner already";};
D207_VehicleListDrone append [_Vehtoaddtpye];
publicVariable "D207_VehicleListDrone";
_hinttext = parseText format ["%1 Added to the Drone Vehicle Spawner", _Vehtoaddtpye];
hint _hinttext;
}] call zen_custom_modules_fnc_register;

waitUntil {Sleep 1; !isNull player;};
_uid = getPlayerUID player;
if (_uid in D207_ZeusUID) then {
	_Player = player;
	[_Player] remoteExec ["D207_fnc_NewZeus", 2];
	player addEventHandler ["Respawn", {[player] remoteExec ["D207_fnc_NewZeus", 2];}];
};

player setVariable ["D207_PlayerConfig", "9-04-26", false];