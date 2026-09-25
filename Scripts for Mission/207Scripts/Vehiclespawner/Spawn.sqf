disableSerialization;

private _display = findDisplay 8100;
if (isNull _display) exitWith {hint "Vehicle spawn menu not found.";};

private _listControl = _display displayCtrl 1500;
private _index = lbCurSel _listControl;
if (_index < 0) exitWith {hint "No vehicle selected.";};

private _className = _listControl lbData _index;
private _openEditor = cbChecked (_display displayCtrl 2800);
private _spawnBase = missionNamespace getVariable ["SpawnBoxLOC", objNull];

closeDialog 1;

if (isNull _spawnBase) exitWith {hint "Vehicle spawn failed: spawner reference was lost.";};
[_spawnBase, _className, _openEditor, player] remoteExec ["D207_fnc_SpawnVehicleServer", 2];
