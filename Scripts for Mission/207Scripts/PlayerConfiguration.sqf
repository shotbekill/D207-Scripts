player addEventHandler ["Killed", {
    params ["_unit"];
    _unit setVariable ["SBK_DeathLoadout", getUnitLoadout _unit];
}];

player addEventHandler ["Respawn", {
    params ["_newUnit", "_oldUnit"];
    private _loadout = _oldUnit getVariable ["SBK_DeathLoadout", []];
    if (_loadout isNotEqualTo []) then {_newUnit setUnitLoadout _loadout;};
    _newUnit enableStamina false;
    [_newUnit] call D207_fnc_RespawnPing;
}];

[] spawn {
    waitUntil {!isNull player};
    private _lastConnectedUAV = objNull;

    while {true} do {
        uiSleep 1;
        private _connectedUAV = getConnectedUAV player;

        if (!isNull _connectedUAV && {unitIsUAV _connectedUAV} && {_connectedUAV != _lastConnectedUAV}) then {
            [_connectedUAV, player] remoteExecCall ["D207_fnc_NameUAV", 2];
        };

        _lastConnectedUAV = _connectedUAV;
    };
};

// Automatically add the Claim UAV ACE self-action.
[] spawn {
    waitUntil {!isNull player && {!isNil "ace_interact_menu_fnc_createAction"}};

    private _claimUAVAction = ["D207_ClaimConnectedUAV", "Claim Connected UAV", "",
        {
            params ["_target", "_player", "_params"];
            private _uav = getConnectedUAV _player;
            if (isNull _uav) exitWith {hint "You are not connected to a UAV.";};
            if !(unitIsUAV _uav) exitWith {hint "The connected vehicle is not a UAV.";};
            [_uav, _player] remoteExecCall ["D207_fnc_ClaimUAV", 2];
        },
        {
            params ["_target", "_player", "_params"];
            if (!alive _player) exitWith {false};
            private _uav = getConnectedUAV _player;
            if (isNull _uav || {!(unitIsUAV _uav)}) exitWith {false};
            private _ownerUID = _uav getVariable ["D207_UAVOwnerUID", ""];
            _ownerUID isEqualTo "" || {_ownerUID isNotEqualTo getPlayerUID _player}
        }
    ] call ace_interact_menu_fnc_createAction;

    ["CAManBase", 1, ["ACE_SelfActions"], _claimUAVAction, true] call ace_interact_menu_fnc_addActionToClass;
};

[["LandVehicle"], ["Convoy Net", "Air Net", "HQ Net", "Medic Net", "CAS Net"]] call mor_fnc_vehicleSatCom;
[["Air"], ["Convoy Net", "Air Net", "HQ Net", "Medic Net", "CAS Net"]] call mor_fnc_vehicleSatCom;

// ZEN modules. UI registration remains client-side, but authoritative state and object creation go to the server.
["207 Modules", "Load In", {
    ["LOAD_IN", _this select 0, player] remoteExecCall ["D207_fnc_ZeusSupportServer", 2];
}] call zen_custom_modules_fnc_register;

["207 Modules", "Game on", {
    ["GAME_ON", _this select 0, player] remoteExecCall ["D207_fnc_ZeusSupportServer", 2];
}] call zen_custom_modules_fnc_register;

["207 Modules", "Game Stop", {
    ["GAME_STOP", _this select 0, player] remoteExecCall ["D207_fnc_ZeusSupportServer", 2];
}] call zen_custom_modules_fnc_register;

["207 Modules", "endex", {
    [(_this select 0), player] call D207_fnc_EndExPos;
}] call zen_custom_modules_fnc_register;

["207 Modules", "Add J5 Spectator", {
    private _unit = _this select 1;
    if (isNull _unit || {!isPlayer _unit}) exitWith {hint "Select a player unit.";};
    [_unit] remoteExecCall ["D207_fnc_Spectator", owner _unit];
}] call zen_custom_modules_fnc_register;

["207 Modules", "Spawn Logi Box", {
    ["SPAWN_LOGI", _this select 0, player] remoteExecCall ["D207_fnc_ZeusSupportServer", 2];
}] call zen_custom_modules_fnc_register;

["207 Modules", "End Op", {
    if !(missionNamespace getVariable ["EndEx", false]) exitWith {hint "EndEx Not Called";};
    if !(missionNamespace getVariable ["EndOp", false]) exitWith {hint "EndOp Has Been Called";};
    [player] call D207_fnc_Outro;
}] call zen_custom_modules_fnc_register;

["207 Logistical", "Berets", {
    ["BERETS", _this select 0, player] remoteExecCall ["D207_fnc_ZeusSupportServer", 2];
}] call zen_custom_modules_fnc_register;

["207 Logistical", "Arsenal", {
    ["ARSENAL", _this select 0, player] remoteExecCall ["D207_fnc_ZeusSupportServer", 2];
}] call zen_custom_modules_fnc_register;

["207 Logistical", "FOB Respawn", {
    ["FOB", _this select 0, player] remoteExecCall ["D207_fnc_ZeusSupportServer", 2];
}] call zen_custom_modules_fnc_register;

["207 Logistical", "Full Resupply Vehicle", {
    ["FULL_RESUPPLY", _this select 0, player] remoteExecCall ["D207_fnc_ZeusSupportServer", 2];
}] call zen_custom_modules_fnc_register;

["207 Logistical", "Box of Keys", {
    ["KEYS", _this select 0, player] remoteExecCall ["D207_fnc_ZeusSupportServer", 2];
}] call zen_custom_modules_fnc_register;

["207 Logistical", "Check Scripts", {
    [_this select 0] call D207_fnc_Checkmission;
}] call zen_custom_modules_fnc_register;

["207 Logistical","Export Box Contents",{
	params ["_position", "_box"];
	if (isNull _box) exitWith {hint "Place the module directly on a box/crate.";};
	[_box] call D207_fnc_exportBoxContents;
}] call zen_custom_modules_fnc_register;

["207 Vehicle Spawner", "Spawn Vehicle Spawner Box", {
    ["SPAWN_VEHICLE_SPAWNER", _this select 0, player] remoteExecCall ["D207_fnc_ZeusSupportServer", 2];
}] call zen_custom_modules_fnc_register;

["207 Vehicle Spawner", "Can Spawn Vehicle", {
    createDialog "CanSpawnVehicle";
    D207_CanSpawnCode = 1;
    execVM "207Scripts\Vehiclespawner\CanSpawnCode.sqf";
}] call zen_custom_modules_fnc_register;

["207 Vehicle Spawner", "Add Vehicle To Platoon Spawner", {
    private _vehicle = _this select 1;
    if (isNull _vehicle) exitWith {hint "Select a vehicle.";};
    private _className = typeOf _vehicle;
    ["ADD_PLATOON", _className, player] remoteExecCall ["D207_fnc_UpdateVehicleSpawnerServer", 2];
    hint format ["%1 Added to the Platoon Vehicle Spawner", _className];
}] call zen_custom_modules_fnc_register;

["207 Vehicle Spawner", "Add Vehicle To Foxtrot Spawner", {
    private _vehicle = _this select 1;
    if (isNull _vehicle) exitWith {hint "Select a vehicle.";};
    private _className = typeOf _vehicle;
    ["ADD_FOXTROT", _className, player] remoteExecCall ["D207_fnc_UpdateVehicleSpawnerServer", 2];
    hint format ["%1 Added to the Foxtrot Vehicle Spawner", _className];
}] call zen_custom_modules_fnc_register;

["207 Vehicle Spawner", "Add Vehicle To Hawkeye Spawner", {
    private _vehicle = _this select 1;
    if (isNull _vehicle) exitWith {hint "Select a vehicle.";};
    private _className = typeOf _vehicle;
    ["ADD_HAWKEYE", _className, player] remoteExecCall ["D207_fnc_UpdateVehicleSpawnerServer", 2];
    hint format ["%1 Added to the Hawkeye Vehicle Spawner", _className];
}] call zen_custom_modules_fnc_register;

["207 Vehicle Spawner", "Add Vehicle To Drone Spawner", {
    private _vehicle = _this select 1;
    if (isNull _vehicle) exitWith {hint "Select a vehicle.";};
    private _className = typeOf _vehicle;
    ["ADD_DRONE", _className, player] remoteExecCall ["D207_fnc_UpdateVehicleSpawnerServer", 2];
    hint format ["%1 Added to the Drone Vehicle Spawner", _className];
}] call zen_custom_modules_fnc_register;

player setVariable ["D207_PlayerConfig", "27-05-26", false];
