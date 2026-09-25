params [
    ["_mode", "", [""]],
    ["_position", [], [[]]],
    ["_caller", objNull, [objNull]]
];

if (!isServer) exitWith {};
if (isNull _caller || {!isPlayer _caller}) exitWith {};
if (isRemoteExecuted && {remoteExecutedOwner != owner _caller}) exitWith {};
if (isNull (getAssignedCuratorLogic _caller)) exitWith {};

private _reply = {
    params ["_text"];
    [format ["<t size='1.1'>%1</t>", _text]] remoteExecCall ["D207_fnc_ClientHint", owner _caller];
};

switch (toUpper _mode) do {
    case "LOAD_IN": {
        missionNamespace setVariable ["LoadIn", true, true];
    };
    case "GAME_ON": {
        if !(missionNamespace getVariable ["LoadIn", false]) exitWith {["Load In has not been placed/called yet."] call _reply;};
        missionNamespace setVariable ["Gameon", true, true];
        missionNamespace setVariable ["GameStop", false, true];
        [] remoteExec ["D207_fnc_GameOn", -2];
    };
    case "GAME_STOP": {
        missionNamespace setVariable ["GameStop", true, true];
        missionNamespace setVariable ["Gameon", false, true];
        [] remoteExec ["D207_fnc_GameStop", -2];
    };
    case "SPAWN_LOGI": {
        if (_position isEqualTo []) exitWith {};
        private _box = "B_Slingload_01_Cargo_F" createVehicle _position;
        _box allowDamage false;
        clearItemCargoGlobal _box;
        clearMagazineCargoGlobal _box;
        clearBackpackCargoGlobal _box;
        clearWeaponCargoGlobal _box;
        [_box, -1] call ace_cargo_fnc_setSize;
        [_box, -1] call ace_cargo_fnc_setSpace;
        [_box] remoteExec ["D207_fnc_InitMoverLogisticalBox", -2, _box];
    };
    case "SPAWN_VEHICLE_SPAWNER": {
        if (_position isEqualTo []) exitWith {};
        private _box = "Land_RepairDepot_01_civ_F" createVehicle _position;
        _box allowDamage false;
        _box enableSimulationGlobal false;
        [_box] remoteExec ["D207_fnc_InitVehicleSpawnerBox", -2, _box];
    };
    case "BERETS": {
        if (_position isNotEqualTo []) then {[_position] call D207_fnc_berets;};
    };
    case "ARSENAL": {
        if (_position isNotEqualTo []) then {[_position] call D207_fnc_Arsenal;};
    };
    case "FOB": {
        if (_position isNotEqualTo []) then {[_position] call D207_fnc_FOBspawn;};
    };
    case "FULL_RESUPPLY": {
        if (_position isNotEqualTo []) then {[_position, _caller] spawn D207_fnc_FullResupply;};
    };
    case "KEYS": {
        if (_position isNotEqualTo []) then {[_position] call D207_fnc_Keys;};
    };
};
