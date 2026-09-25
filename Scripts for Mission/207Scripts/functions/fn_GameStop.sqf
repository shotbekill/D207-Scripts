if (isServer) then {
    missionNamespace setVariable ["Gameon", false, true];
};

if (hasInterface) then {
    "ALL Stop" hintC [
        "Stop where you are.",
        "Don't do anything with any objects.",
        "You may heal yourself but not anyone else.",
        "Please wait for Game On before doing anything."
    ];

    private _display = findDisplay 72;
    if (!isNull _display) then {
        private _eh = _display displayAddEventHandler ["Unload", {
            params ["_display"];
            private _eh = uiNamespace getVariable ["D207_GameStopHintEH", -1];
            if (_eh >= 0) then {
                _display displayRemoveEventHandler ["Unload", _eh];
            };
            uiNamespace setVariable ["D207_GameStopHintEH", -1];
            hintSilent "";
        }];
        uiNamespace setVariable ["D207_GameStopHintEH", _eh];
    };
};
