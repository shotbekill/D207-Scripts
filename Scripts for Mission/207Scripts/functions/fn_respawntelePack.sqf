params ["_vehicle"];
systemChat "Packing up Spawn Relocator, This will take some time";
missionNamespace setVariable ["Relocator", nil, true];
_3DSelectorSP = [[_vehicle, "GROUND"], "VR_3DSelector_01_exit_F", 1, [-4.53,2.3,0], (0),{0},false] call BIS_fnc_spawnObjects;
_3DSelector = _3DSelectorSP select 0;
_3DSelector hideObjectGlobal true;
_trg = createTrigger ["EmptyDetector", getPos _3DSelector, false];
_trg setTriggerArea [12, 22, 0, true];
_vehiclesIN = allMissionObjects "" inAreaArray _trg;
{
	if (_X isKindOf "Land_HBarrier_5_F" || _X isKindOf "Land_HBarrier_3_F" || _X isKindOf "Land_SandbagBarricade_01_F" || _X isKindOf "Land_MedicalTent_01_MTP_closed_F" || _X isKindOf "Land_CampingTable_small_F" || _X isKindOf "Land_Laptop_device_F" || _X isKindOf "Land_HelipadRescue_F" || _X isKindOf "VR_3DSelector_01_exit_F") then {deleteVehicle _X;sleep 2;};
} forEach _vehiclesIN;
deleteVehicle _trg;
sleep 1;
_vehicle allowDamage true;
_vehicle enableSimulation true;
systemChat "Spawn Relocator Has Been Packed";
missionNamespace setVariable ["SpawnRelocator", false, true];