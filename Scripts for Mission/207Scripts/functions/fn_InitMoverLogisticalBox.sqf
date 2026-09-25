params [["_moverBox", objNull, [objNull]]];
if (!hasInterface || {isNull _moverBox}) exitWith {};
if (_moverBox getVariable ["D207_MoverLogiActionsAdded", false]) exitWith {};
_moverBox setVariable ["D207_MoverLogiActionsAdded", true, false];

private _mainAction = ["D207_MoverLogi", "<t color='#013DB7'>Unpack Logistical Box</t>", "", {nil}, {true}, {}, [], [0,0,0.3], 7] call ace_interact_menu_fnc_createAction;
[_moverBox, 0, [], _mainAction] call ace_interact_menu_fnc_addActionToObject;

private _foxtrotAction = ["D207_MoverLogiFoxtrot", "<t color='#FF0000'>Foxtrot</t>", "",
    {[_target, 1, _player] remoteExecCall ["D207_fnc_UnPackLogisticalBox", 2];},
    {alive _target && {!(_target getVariable ["D207_LogiBusy", false])}}
] call ace_interact_menu_fnc_createAction;
[_moverBox, 0, ["D207_MoverLogi"], _foxtrotAction] call ace_interact_menu_fnc_addActionToObject;

private _hawkeyeAction = ["D207_MoverLogiHawkeye", "<t color='#00FFFF'>Hawkeye</t>", "",
    {[_target, 2, _player] remoteExecCall ["D207_fnc_UnPackLogisticalBox", 2];},
    {alive _target && {!(_target getVariable ["D207_LogiBusy", false])}}
] call ace_interact_menu_fnc_createAction;
[_moverBox, 0, ["D207_MoverLogi"], _hawkeyeAction] call ace_interact_menu_fnc_addActionToObject;
