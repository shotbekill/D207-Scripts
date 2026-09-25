params [
    ["_success", false, [false]],
    ["_message", "", [""]],
    ["_vehicle", objNull, [objNull]],
    ["_openEditor", false, [false]]
];

if (!hasInterface) exitWith {};
if (_message isNotEqualTo "") then {
    systemChat _message;
    if (!_success) then {hint _message;};
};

if (_success && {_openEditor} && {!isNull _vehicle}) then {
    [_vehicle] spawn {
        params ["_vehicle"];
        uiSleep 0.25;
        if (!isNull _vehicle) then {[_vehicle] call D207_fnc_openVehicleEditor;};
    };
};
