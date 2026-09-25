private _spawnBase = missionNamespace getVariable ["SpawnBoxLOC", objNull];
if (isNull _spawnBase) exitWith {hint "Vehicle spawner reference is missing.";};
closeDialog 1;
hint composeText ["Blue Arrow shows spawn POS", lineBreak, "GUI will auto open in 5 sec"];
private _selector = [[_spawnBase, "TOP"], "VR_3DSelector_01_default_F", 1, [0,20,0], (0),{0},false] call BIS_fnc_spawnObjects;
uiSleep 5;
[_spawnBase] execVM "207Scripts\Vehiclespawner\StartDialog.sqf";
uiSleep 3;
deleteVehicle _selector;