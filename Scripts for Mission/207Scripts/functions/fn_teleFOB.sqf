params [["_vehicle", objNull, [objNull]]];
if (!hasInterface || {isNull _vehicle}) exitWith {};
if (_vehicle getVariable ["D207_FOBActionsAdded", false]) exitWith {};
_vehicle setVariable ["D207_FOBActionsAdded", true];

private _mainAction = ["D207_FOBRespawn", "<t color='#207207'>FOB Respawn</t>", "", {nil}, {true}, {}, [], [0,0,-1], 7] call ace_interact_menu_fnc_createAction;
[_vehicle, 0, [], _mainAction] call ace_interact_menu_fnc_addActionToObject;

private _setupAction = ["D207_SetupFOB", "<t color='#ff0000'>Set Up FOB spawn</t>", "",
    {[_target, _player] remoteExec ["D207_fnc_RelocatorFOB", 2];},
    {!(_target getVariable ["FOBSpawn", false])}
] call ace_interact_menu_fnc_createAction;
[_vehicle, 0, ["D207_FOBRespawn"], _setupAction] call ace_interact_menu_fnc_addActionToObject;
