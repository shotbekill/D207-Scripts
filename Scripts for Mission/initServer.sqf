["Initialize", [true]] call BIS_fnc_dynamicGroups;
_ServerConfig = [] execVM "207Scripts\ServerConfiguration.sqf";
waitUntil {
	scriptDone _ServerConfig
};
missionNamespace setVariable ["Startup", true, true];
missionNamespace setVariable ["D207_ServerConfigInit", "16-03-26", true];