_ctrlPLT = (findDisplay 8200) displayCtrl 1000;
_ctrlFOX = (findDisplay 8200) displayCtrl 1001;
_ctrlHAW = (findDisplay 8200) displayCtrl 1002;
_ctrlDrone = (findDisplay 8200) displayCtrl 1003;
if (D207_CanSpawnCode == 0) then {
	if (D207_CanSpawnBool == 0) then {
		_ctrlPLT = (findDisplay 8200) displayCtrl 1000;
		_ctrlFOX = (findDisplay 8200) displayCtrl 1001;
		_ctrlHAW = (findDisplay 8200) displayCtrl 1002;
		_ctrlDrone = (findDisplay 8200) displayCtrl 1003;
		if (D207_VehiclePlatoon) then {_ctrlPLT ctrlSetBackgroundColor [0.7, 0, 0, 0.5];} else {_ctrlPLT ctrlSetBackgroundColor [0, 0.7, 0, 0.5];};
		if (D207_VehicleFoxtrot) then {_ctrlFOX ctrlSetBackgroundColor [0.7, 0, 0, 0.5];} else {_ctrlFOX ctrlSetBackgroundColor [0, 0.7, 0, 0.5];};
		if (D207_VehicleHawkeye) then {_ctrlHAW ctrlSetBackgroundColor [0.7, 0, 0, 0.5];} else {_ctrlHAW ctrlSetBackgroundColor [0, 0.7, 0, 0.5];};
		if (D207_VehicleDrone) then {_ctrlDrone ctrlSetBackgroundColor [0.7, 0, 0, 0.5];} else {_ctrlDrone ctrlSetBackgroundColor [0, 0.7, 0, 0.5];};
	};
};
if (D207_CanSpawnCode == 1) then {
	if (D207_CanSpawnBool == 1) then {
		missionNamespace setVariable ['D207_VehiclePlatoon', false, true];
		_ctrlPLT ctrlSetBackgroundColor [0, 0.7, 0, 0.5];
	};
	if (D207_CanSpawnBool == 2) then {
		missionNamespace setVariable ['D207_VehiclePlatoon', true, true];
		_ctrlPLT ctrlSetBackgroundColor [0.7, 0, 0, 0.5];
	};
};
if (D207_CanSpawnCode == 2) then {
	if (D207_CanSpawnBool == 1) then {
		missionNamespace setVariable ['D207_VehicleFoxtrot', false, true];
		_ctrlFOX ctrlSetBackgroundColor [0, 0.7, 0, 0.5];
	};
	if (D207_CanSpawnBool == 2) then {
		missionNamespace setVariable ['D207_VehicleFoxtrot', true, true];
		_ctrlFOX ctrlSetBackgroundColor [0.7, 0, 0, 0.5];
	};
};
if (D207_CanSpawnCode == 3) then {
	if (D207_CanSpawnBool == 1) then {
		missionNamespace setVariable ['D207_VehicleHawkeye', false, true];
		_ctrlHAW ctrlSetBackgroundColor [0, 0.7, 0, 0.5];
	};
	if (D207_CanSpawnBool == 2) then {
		missionNamespace setVariable ['D207_VehicleHawkeye', true, true];
		_ctrlHAW ctrlSetBackgroundColor [0.7, 0, 0, 0.5];
	};
};
if (D207_CanSpawnCode == 4) then {
	if (D207_CanSpawnBool == 1) then {
		missionNamespace setVariable ['D207_VehicleDrone', false, true];
		_ctrlDrone ctrlSetBackgroundColor [0, 0.7, 0, 0.5];
	};
	if (D207_CanSpawnBool == 2) then {
		missionNamespace setVariable ['D207_VehicleDrone', true, true];
		_ctrlDrone ctrlSetBackgroundColor [0.7, 0, 0, 0.5];
	};
};
if (D207_CanSpawnCode == 5) then {
	if (D207_CanSpawnBool == 1) then {
		missionNamespace setVariable ['D207_VehiclePlatoon', true, true];
		missionNamespace setVariable ['D207_VehicleFoxtrot', true, true];
		missionNamespace setVariable ['D207_VehicleHawkeye', true, true];
		missionNamespace setVariable ['D207_VehicleDrone', true, true];
		_ctrlPLT ctrlSetBackgroundColor [0.7, 0, 0, 0.5];
		_ctrlFOX ctrlSetBackgroundColor [0.7, 0, 0, 0.5];
		_ctrlHAW ctrlSetBackgroundColor [0.7, 0, 0, 0.5];
		_ctrlDrone ctrlSetBackgroundColor [0.7, 0, 0, 0.5];
	};
	if (D207_CanSpawnBool == 2) then {
		missionNamespace setVariable ['D207_VehiclePlatoon', false, true];
		missionNamespace setVariable ['D207_VehicleFoxtrot', false, true];
		missionNamespace setVariable ['D207_VehicleHawkeye', false, true];
		missionNamespace setVariable ['D207_VehicleDrone', false, true];
		_ctrlPLT ctrlSetBackgroundColor [0, 0.7, 0, 0.5];
		_ctrlFOX ctrlSetBackgroundColor [0, 0.7, 0, 0.5];
		_ctrlHAW ctrlSetBackgroundColor [0, 0.7, 0, 0.5];
		_ctrlDrone ctrlSetBackgroundColor [0, 0.7, 0, 0.5];
	};
};