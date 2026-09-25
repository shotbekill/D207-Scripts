params [
    ["_mode", "", [""]],
    ["_laptop", objNull, [objNull]]
];

switch (_mode) do {
    case "CREATE": {
        if (!hasInterface || {isNull _laptop}) exitWith {};
        private _respawn = ["Respawn", "<t color='#207207'>Respawn Laptop</t>", "", {nil}, {true}, {}, [], [0,0,0], 7] call ace_interact_menu_fnc_createAction;
        [_laptop,0,[],_respawn] call ace_interact_menu_fnc_addActionToObject;
        private _ping = ["Ping", "<t color='#00FFEA'>Ping For Reinsertion</t>", "", {[] spawn D207_fnc_Reinsertionping;}, {true}] call ace_interact_menu_fnc_createAction;
        [_laptop,0,["Respawn"],_ping] call ace_interact_menu_fnc_addActionToObject;
        private _heal = ["HealBase", "<t color='#00FF00'>Heal</t>", "", {[objNull,player] call ace_medical_treatment_fnc_fullHeal;}, {true}] call ace_interact_menu_fnc_createAction;
        [_laptop,0,["Respawn"],_heal] call ace_interact_menu_fnc_addActionToObject;
        private _moveToFOB = ["MoveToFOB", "<t color='#ff0000'>Move To FOB</t>", "", {[1] spawn D207_fnc_teleport;}, {!isNull (missionNamespace getVariable ["FOBTELE",objNull])}] call ace_interact_menu_fnc_createAction;
        [_laptop,0,["Respawn"],_moveToFOB] call ace_interact_menu_fnc_addActionToObject;
        private _moveToRelocator = ["MoveToRelocator", "<t color='#ff0000'>Move To Spawn Relocator</t>", "", {[2] spawn D207_fnc_teleport;}, {missionNamespace getVariable ["SpawnRelocator",false] && {!isNull (missionNamespace getVariable ["Relocator",objNull])}}] call ace_interact_menu_fnc_createAction;
        [_laptop,0,["Respawn"],_moveToRelocator] call ace_interact_menu_fnc_addActionToObject;
    };
    case "FOB": {[1] spawn D207_fnc_teleport;};
    case "Relocator": {[2] spawn D207_fnc_teleport;};
};
