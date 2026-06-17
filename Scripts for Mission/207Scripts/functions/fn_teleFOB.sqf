params ["_vehicle"];
_vehicle setVariable ["FOBSpawn", false, true];
_MediMove = ["MediMove", "<t color='#207207'>FOB Respawn</t>","",{nil}, {true}, {}, [], [0, 0, -1], 7] call ace_interact_menu_fnc_createAction;
[_vehicle, 0, [], _MediMove]  call ace_interact_menu_fnc_addActionToObject;
_spawnMove = ["spawnMove", "<t color='#ff0000'>Set Up FOB spawn</t>","",{[_target] spawn D207_fnc_respawnteleFOB;}, {!(_target getVariable "FOBSpawn")}] call ace_interact_menu_fnc_createAction;
[_vehicle, 0, ["MediMove"], _spawnMove]  call ace_interact_menu_fnc_addActionToObject;
