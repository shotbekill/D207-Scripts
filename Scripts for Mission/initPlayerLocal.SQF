["InitializePlayer", [player, true]] call BIS_fnc_dynamicGroups;
player setUnitTrait ["loadCoef", -2];
player enableStamina false;

private _playerConfig = [] execVM "207Scripts\PlayerConfiguration.sqf";
waitUntil {scriptDone _playerConfig};

player setVariable ["D207_PlayerConfigInit", "16-03-26", false];
