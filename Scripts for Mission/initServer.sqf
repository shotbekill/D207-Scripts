["Initialize", [true]] call BIS_fnc_dynamicGroups;

private _serverConfig = [] execVM "207Scripts\ServerConfiguration.sqf";
waitUntil {scriptDone _serverConfig};

missionNamespace setVariable ["Startup", true, true];
missionNamespace setVariable ["D207_ServerConfigInit", "16-03-26", true];
