
player addEventHandler ["Killed", { player setVariable ["SBK_DeathLoadout", getUnitLoadout player]; }];
player addEventHandler ["Respawn", {
private _loadout = player getVariable "SBK_DeathLoadout";
if (!isNil "_loadout") then { player setUnitLoadout _loadout;};
player enableStamina false;
[player] call D207_fnc_RespawnPing;
}];

[] spawn {
	waitUntil { !isNull player };
	private _lastConnectedUAV = objNull;
	while { true } do {
		uiSleep 1;
		private _connectedUAV = getConnectedUAV player;
		/*
			Player has connected to a UAV, or changed
			to a different connected UAV.
		*/
		if (
			!isNull _connectedUAV &&
			{ unitIsUAV _connectedUAV } &&
			{ _connectedUAV != _lastConnectedUAV }
		) then {
			[
				_connectedUAV,
				player
			] remoteExecCall [
				"D207_fnc_NameUAV",
				2
			];
		};
		/*
			Allow another connection event after disconnecting.
		*/
		if (isNull _connectedUAV) then {
			_lastConnectedUAV = objNull;
		} else {
			_lastConnectedUAV = _connectedUAV;
		};
	};
};
// Automatically adds the Claim UAV ACE self-action
[] spawn {
	waitUntil {!isNull player && { !isNil "ace_interact_menu_fnc_createAction" }};
	private _claimUAVAction = ["D207_ClaimConnectedUAV","Claim Connected UAV","",
		{
			params ["_target", "_player", "_params"];
			private _uav = getConnectedUAV _player;
			if (isNull _uav) exitWith {hint "You are not connected to a UAV.";};
			if !(unitIsUAV _uav) exitWith {hint "The connected vehicle is not a UAV.";};
			[_uav,_player] remoteExecCall ["D207_fnc_ClaimUAV",2];
		},{
			params ["_target", "_player", "_params"];
			if (!alive _player) exitWith {false};
			private _uav = getConnectedUAV _player;
			if (isNull _uav) exitWith {false};
			if !(unitIsUAV _uav) exitWith {false};
			private _ownerUID = _uav getVariable ["D207_UAVOwnerUID",""];
			// Show when unowned or owned by another player.
			_ownerUID isEqualTo "" || {_ownerUID isNotEqualTo getPlayerUID _player}
		}
	] call ace_interact_menu_fnc_createAction;
	["CAManBase",1,["ACE_SelfActions"],_claimUAVAction,true] call ace_interact_menu_fnc_addActionToClass;
};

[["LandVehicle"], ["Convoy Net","Air Net","HQ Net","Medic Net","CAS Net"]] call mor_fnc_vehicleSatCom;
[["Air"], ["Convoy Net","Air Net","HQ Net","Medic Net","CAS Net"]] call mor_fnc_vehicleSatCom;

["207 Modules", "Load In", {missionNamespace setVariable ["LoadIn", true, true];}] call zen_custom_modules_fnc_register;
["207 Modules", "Game on", {if (LoadIn) then {missionNamespace setVariable ["Gameon", true, true];} else {hint "Load In not placed"};}] call zen_custom_modules_fnc_register;
["207 Modules", "Game Stop", {missionNamespace setVariable ["GameStop", true, true];}] call zen_custom_modules_fnc_register;
["207 Modules", "endex", {[_this select 0] call D207_fnc_EndExPos;}] call zen_custom_modules_fnc_register;
["207 Modules", "Add J5 Spectator", {_this select 1 addEventHandler ["Respawn", {remoteExec ["D207_fnc_Spectator", _this select 1];}];remoteExec ["D207_fnc_Spectator",_this select 1];}] call zen_custom_modules_fnc_register;
["207 Modules", "Spawn Logi Box", {_Box = "B_Slingload_01_Cargo_F" createVehicle (_this select 0);[_Box] spawn D207_fnc_MoveLogisticalBox;}] call zen_custom_modules_fnc_register;
["207 Modules", "End Op", {if (EndEx) then {if (EndOp) then {[_this select 0] call D207_fnc_Outro;} else {hint "EndOp Has Been Called"};} else {hint "EndEx Not Called"};}] call zen_custom_modules_fnc_register;
["207 Logistical", "Berets", {[_this select 0] call D207_fnc_berets;}] call zen_custom_modules_fnc_register;
["207 Logistical", "Arsenal", {[_this select 0] call D207_fnc_Arsenal;}] call zen_custom_modules_fnc_register;
["207 Logistical", "FOB Respawn", {[_this select 0] call D207_fnc_FOBspawn;}] call zen_custom_modules_fnc_register;
["207 Logistical", "Full Resupply Vehicle", {[_this select 0] Spawn D207_fnc_FullResupply;}] call zen_custom_modules_fnc_register;
["207 Logistical", "Box of Keys", {[_this select 0] call D207_fnc_Keys;}] call zen_custom_modules_fnc_register;
["207 Logistical", "Check Scripts", {[_this select 0] call D207_fnc_Checkmission;}] call zen_custom_modules_fnc_register;

["207 Vehicle Spawner", "Spawn Vehicle Spawner Box", {
_Box = "Land_RepairDepot_01_civ_F" createVehicle (_this select 0);
[_Box,"207Scripts\VehicleSpawnBoxScript.sqf"] remoteExec ["execVM", 0, true];
_Box allowDamage false;
_Box enableSimulation false;
}] call zen_custom_modules_fnc_register;
["207 Vehicle Spawner", "Can Spawn Vehicle", {createDialog "CanSpawnVehicle";D207_CanSpawnCode = 1; execVM '207Scripts\Vehiclespawner\CanSpawnCode.sqf';}] call zen_custom_modules_fnc_register;
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
player setVariable ["D207_PlayerConfig", "27-05-26", false];