params ["_box"];
waitUntil {!isNil "Startup"};
if (hasInterface) then {
waitUntil {missionNamespace getVariable "Startup"};
_box spawn D207_fnc_Arsenalitems;
_D207 = ["D207", "<t color='#207207'>Vehicle Spawner</t>","",{
[_target] execVM "207Scripts\Vehiclespawner\StartDialog.sqf"
}, {true}, {}, [], [0, 0, -1], 7] call ace_interact_menu_fnc_createAction; 
[_box, 0, [], _D207]  call ace_interact_menu_fnc_addActionToObject;
};