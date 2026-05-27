params ["_vehicle"];

_MediMove = ["MediMove", "<t color='#207207'>Medical Respawn</t>","",{nil}, {true}, {}, [], [0, 0, -1], 7] call ace_interact_menu_fnc_createAction;
[_vehicle, 0, [], _MediMove]  call ace_interact_menu_fnc_addActionToObject;

_CheckLOC = ["CheckLOC", "<t color='#ff0000'>Check LOC</t>","",{[_target] spawn D207_fnc_respawntelecheck;}, {!(missionNamespace getVariable "SpawnRelocator")}] call ace_interact_menu_fnc_createAction;
[_vehicle, 0, ["MediMove"], _CheckLOC]  call ace_interact_menu_fnc_addActionToObject;

_spawnMove = ["spawnMove", "<t color='#ff0000'>Set Up spawn Mover</t>","",{[_target] spawn D207_fnc_respawnteleMove;}, {!(missionNamespace getVariable "SpawnRelocator")}] call ace_interact_menu_fnc_createAction;
[_vehicle, 0, ["MediMove"], _spawnMove]  call ace_interact_menu_fnc_addActionToObject;

_spawnPack = ["spawnPack", "<t color='#ff0000'>Pack Up spawn Mover</t>","",{[_target] spawn D207_fnc_respawntelePack;}, {missionNamespace getVariable "SpawnRelocator" && !isNil "Relocator"}] call ace_interact_menu_fnc_createAction;
[_vehicle, 0, ["MediMove"], _spawnPack]  call ace_interact_menu_fnc_addActionToObject;
/*

_Respawn = ["Respawn", "<t color='#207207'>Respawn LapTop</t>","",{nil}, {true}, {}, [], [0, 0, 0], 7] call ace_interact_menu_fnc_createAction;
[this, 0, [], _Respawn]  call ace_interact_menu_fnc_addActionToObject;
_Ping = ["Ping", "<t color='#00FFEA'>Ping For Reinsertion</t>","",{[] spawn D207_fnc_Reinsertionping;}, {true}] call ace_interact_menu_fnc_createAction;
[this, 0, ["Respawn"], _Ping]  call ace_interact_menu_fnc_addActionToObject;
_Heal = ["HealBase", "<t color='#00FF00'>Heal</t>","",{player setDamage 0;}, {true}] call ace_interact_menu_fnc_createAction;
[this, 0, ["Respawn"], _Heal]  call ace_interact_menu_fnc_addActionToObject;
_MoveToRelocator = ["MoveToRelocator", "<t color='#ff0000'>Move To Spawn Relocator</t>","",{Player setPos (getPos Relocator);}, {missionNamespace getVariable "SpawnRelocator" && !isNil "Relocator"}] call ace_interact_menu_fnc_createAction;
[this, 0, ["Respawn"], _MoveToRelocator]  call ace_interact_menu_fnc_addActionToObject;