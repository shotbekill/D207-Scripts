params [["_unit", objNull, [objNull]]];
if (!hasInterface) exitWith {};
if (isNull _unit || {player isNotEqualTo _unit}) exitWith {};

private _oldAction = player getVariable ["D207_SpectatorAction", -1];
if (_oldAction >= 0) then {player removeAction _oldAction;};

private _actionId = player addAction ["Spectator", {
    ["Initialize", [player]] call BIS_fnc_EGSpectator;
}];
player setVariable ["D207_SpectatorAction", _actionId];

if !(player getVariable ["D207_SpectatorRespawnEH", false]) then {
    player setVariable ["D207_SpectatorRespawnEH", true];
    player addEventHandler ["Respawn", {
        params ["_newUnit"];
        [_newUnit] call D207_fnc_Spectator;
    }];
};

if (isNil {uiNamespace getVariable "D207_SpectatorMonitor"}) then {
    private _handle = [] spawn {
        while {hasInterface} do {
            waitUntil {uiSleep 0.25; !isNull findDisplay 49};
            ["Terminate"] call BIS_fnc_EGSpectator;
            waitUntil {uiSleep 0.25; isNull findDisplay 49};
        };
    };
    uiNamespace setVariable ["D207_SpectatorMonitor", _handle];
};
