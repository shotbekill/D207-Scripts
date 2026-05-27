params ["_vehicle"];

_3DSelectorFR = [[_vehicle, "GROUND"], "VR_3DSelector_01_incomplete_F", 1, [-12.5,22.75,0], (0),{0},false] call BIS_fnc_spawnObjects;
_3DSelectorFL = [[_vehicle, "GROUND"], "VR_3DSelector_01_incomplete_F", 1, [3.5,22.75,0], (0),{0},false] call BIS_fnc_spawnObjects;
_3DSelectorBR = [[_vehicle, "GROUND"], "VR_3DSelector_01_incomplete_F", 1, [-12.5,-16.75,0], (0),{0},false] call BIS_fnc_spawnObjects;
_3DSelectorBL = [[_vehicle, "GROUND"], "VR_3DSelector_01_incomplete_F", 1, [3.5,-16.75,0], (0),{0},false] call BIS_fnc_spawnObjects;
_3DSelectorSP = [[_vehicle, "GROUND"], "VR_3DSelector_01_exit_F", 1, [-4.5,-4.75,0], (0),{0},false] call BIS_fnc_spawnObjects;
_SelectorFR = _3DSelectorFR select 0;
_SelectorFL = _3DSelectorFL select 0;
_SelectorBR = _3DSelectorBR select 0;
_SelectorBL = _3DSelectorBL select 0;
_SelectorSP= _3DSelectorSP select 0;
sleep 10;
deleteVehicle _SelectorFR;
deleteVehicle _SelectorFL;
deleteVehicle _SelectorBR;
deleteVehicle _SelectorBL;
deleteVehicle _SelectorSP;