params [
    ["_logiBox", objNull, [objNull]],
    ["_caller", objNull, [objNull]]
];

if (!isServer) exitWith {
    [_logiBox, player] remoteExecCall ["D207_fnc_MoveLogisticalBox", 2];
};
if (isNull _logiBox) exitWith {};
if (!isNull _caller && {!isPlayer _caller}) exitWith {};
if (!isNull _caller && {isRemoteExecuted} && {remoteExecutedOwner != owner _caller}) exitWith {};
if (!isNull _caller && {_caller distance _logiBox > 10}) exitWith {};
if (_logiBox getVariable ["D207_LogiBusy", false]) exitWith {};
_logiBox setVariable ["D207_LogiBusy", true, true];

private _position = getPosATL _logiBox;
private _direction = getDir _logiBox;
private _moverBox = createVehicle ["B_Slingload_01_Cargo_F", _position, [], 0, "CAN_COLLIDE"];
if (isNull _moverBox) exitWith {
    _logiBox setVariable ["D207_LogiBusy", false, true];
};

_moverBox setDir _direction;
_moverBox allowDamage false;
clearItemCargoGlobal _moverBox;
clearMagazineCargoGlobal _moverBox;
clearBackpackCargoGlobal _moverBox;
clearWeaponCargoGlobal _moverBox;
[_moverBox, -1] call ace_cargo_fnc_setSize;
[_moverBox, -1] call ace_cargo_fnc_setSpace;

deleteVehicle _logiBox;
[_moverBox] remoteExec ["D207_fnc_InitMoverLogisticalBox", -2, _moverBox];

if (!isNull _caller) then {
    ["<t color='#207207'>Logistical box packed and ready to move.</t>"] remoteExecCall ["D207_fnc_ClientHint", owner _caller];
};
