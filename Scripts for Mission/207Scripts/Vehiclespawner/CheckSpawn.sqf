closeDialog 1;
hint composeText ["Blue Arrow shows spawn POS", lineBreak, "GUI will auto open in 5 sec"];
_Checkspawn = [[SpawnBoxLOC, "TOP"], "VR_3DSelector_01_default_F", 1, [0,20,0], (0),{0},false] call BIS_fnc_spawnObjects;
_CheckspawnLOC = _Checkspawn select 0;
sleep 5;
execVM "207Scripts\Vehiclespawner\StartDialog.sqf";
sleep 3;
deleteVehicle _CheckspawnLOC;