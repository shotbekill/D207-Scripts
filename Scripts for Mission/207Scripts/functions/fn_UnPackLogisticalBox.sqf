params [
    ["_moverBox", objNull, [objNull]],
    ["_moverBoxType", 0, [0]],
    ["_caller", objNull, [objNull]]
];

if (!isServer) exitWith {
    [_moverBox, _moverBoxType, player] remoteExecCall ["D207_fnc_UnPackLogisticalBox", 2];
};
if (isNull _moverBox || {!(_moverBoxType in [1,2])}) exitWith {};
if (!isNull _caller && {!isPlayer _caller}) exitWith {};
if (!isNull _caller && {isRemoteExecuted} && {remoteExecutedOwner != owner _caller}) exitWith {};
if (!isNull _caller && {_caller distance _moverBox > 10}) exitWith {};
if (_moverBox getVariable ["D207_LogiBusy", false]) exitWith {};
_moverBox setVariable ["D207_LogiBusy", true, true];

private _position = getPosATL _moverBox;
private _direction = getDir _moverBox;
private _className = if (_moverBoxType == 1) then {"Land_RepairDepot_01_green_F"} else {"Land_RepairDepot_01_tan_F"};
private _logiBox = createVehicle [_className, _position, [], 0, "CAN_COLLIDE"];
if (isNull _logiBox) exitWith {
    _moverBox setVariable ["D207_LogiBusy", false, true];
};

_logiBox setDir _direction;
_logiBox allowDamage false;
_logiBox enableSimulationGlobal false;
deleteVehicle _moverBox;
[_logiBox] remoteExec ["D207_fnc_InitLogisticalBox", -2, _logiBox];

if (!isNull _caller) then {
    ["<t color='#207207'>Logistical box unpacked and ready.</t>"] remoteExecCall ["D207_fnc_ClientHint", owner _caller];
};
