params [["_box", objNull, [objNull]]];
if (!hasInterface || {isNull _box}) exitWith {};
waitUntil {uiSleep 0.1; missionNamespace getVariable ["Startup", false]};
if (_box getVariable ["D207_VehicleSpawnerActionsAdded", false]) exitWith {};
_box setVariable ["D207_VehicleSpawnerActionsAdded", true];

_box spawn D207_fnc_Arsenalitems;
private _action = ["D207_VehicleSpawner", "<t color='#207207'>Vehicle Spawner</t>", "",
    {[_target] execVM "207Scripts\Vehiclespawner\StartDialog.sqf"},
    {true}, {}, [], [0, 0, -1], 7
] call ace_interact_menu_fnc_createAction;
[_box, 0, [], _action] call ace_interact_menu_fnc_addActionToObject;
