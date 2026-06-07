disableSerialization;

// Get selected vehicle BEFORE closing dialog
private _display = findDisplay 8100;
if (isNull _display) exitWith {
	hint "Vehicle spawn menu not found.";
};
private _ctrl = _display displayCtrl 1500;
private _index = lbCurSel _ctrl;
if (_index < 0) exitWith {
	hint "No vehicle selected.";
};
private _info = _ctrl lbData _index;
closeDialog 1;
// Vehicle restriction checks
private _platoonList = missionNamespace getVariable ["D207_VehicleListPlatoon", []];
private _foxtrotList = missionNamespace getVariable ["D207_VehicleListFoxtrot", []];
private _hawkeyeList = missionNamespace getVariable ["D207_VehicleListHawkeye", []];
private _droneList = missionNamespace getVariable ["D207_VehicleListDrone", []];
private _platoonLocked = missionNamespace getVariable ["D207_VehiclePlatoon", false];
private _foxtrotLocked = missionNamespace getVariable ["D207_VehicleFoxtrot", false];
private _hawkeyeLocked = missionNamespace getVariable ["D207_VehicleHawkeye", false];
private _droneLocked = missionNamespace getVariable ["D207_VehicleDrone", false];
if ((_info in _platoonList) && {_platoonLocked}) exitWith {
	hint "You can not spawn Platoon Vehicles. Ping a Zeus";
};
if ((_info in _foxtrotList) && {_foxtrotLocked}) exitWith {
	hint "You can not spawn Foxtrot Vehicles. Ping a Zeus";
};
if ((_info in _hawkeyeList) && {_hawkeyeLocked}) exitWith {
	hint "You can not spawn Hawkeye Vehicles. Ping a Zeus";
};
if ((_info in _droneList) && {_droneLocked}) exitWith {
	hint "You can not spawn Drones at this time. Ping a Zeus";
};
// Base spawn info
private _spawnBase = SpawnBoxLOC;
private _dir = getDir _spawnBase;
// Main check position: 20m in front of SpawnBoxLOC
private _checkPosition = _spawnBase modelToWorld [0, 20, 0];
// Safe place to move players before deleting old vehicles
private _playerSafePos = _spawnBase modelToWorld [0, -5, 0];
// Clear all vehicles in spawn zone
private _vehiclesInSpawn = nearestObjects [
	_checkPosition,
	["LandVehicle", "Air", "Ship"],
	10,
	true
];
{
	private _oldVehicle = _x;
	// Remove crew safely before deleting vehicle
	{
		private _unit = _x;
		if (isPlayer _unit) then {
			unassignVehicle _unit;
			moveOut _unit;
			_unit setPosATL _playerSafePos;
		} else {
			deleteVehicle _unit;
		};
	} forEach crew _oldVehicle;
	sleep 0.1;
	deleteVehicle _oldVehicle;
} forEach _vehiclesInSpawn;
sleep 0.5;
// Check if the spawn point is over water
private _isWater = surfaceIsWater _checkPosition;
private _spawnPosition = [];
if (_isWater) then {
	_spawnPosition = _spawnBase modelToWorld [0, 20, 3];
} else {
	_spawnPosition = _checkPosition;
};
// Spawn vehicle
private _vehicle = createVehicle [_info, _spawnPosition, [], 0, "CAN_COLLIDE"];
_vehicle setDir _dir;
if (_isWater) then {
	_vehicle setPosATL _spawnPosition;
} else {
	_vehicle setVehiclePosition [
		[_spawnPosition select 0, _spawnPosition select 1, 0],
		[],
		0,
		"CAN_COLLIDE"
	];
};
sleep 0.5;
// UAV crew setup
if (unitIsUAV _vehicle) then {
	private _playerSide = playerSide;
	private _newGroup = createGroup [_playerSide, true];
	createVehicleCrew _vehicle;
	private _crew = crew _vehicle;
	_crew joinSilent _newGroup;
	_newGroup addVehicle _vehicle;
};
// Clear vehicle cargo
clearWeaponCargoGlobal _vehicle;
clearMagazineCargoGlobal _vehicle;
clearItemCargoGlobal _vehicle;
clearBackpackCargoGlobal _vehicle;
// H60 texture setup
if (_vehicle isKindOf "vtx_H60_base") then {
	_vehicle setObjectTextureGlobal [16, "asd207_hawkeye_textures\data\textures\d207_australia\asd207_main_co.paa"];
	_vehicle setObjectTextureGlobal [17, "asd207_hawkeye_textures\data\textures\d207_australia\asd207_misc_co.paa"];
	_vehicle setObjectTextureGlobal [18, "asd207_hawkeye_textures\data\textures\d207_australia\asd207_tail_co.paa"];
	_vehicle setObjectTextureGlobal [19, "hue_additions_h60-skins-and-markings\markings\207.paa"];
	_vehicle animateSource ["Fuelprobe_Show", 0, true];
	_vehicle animateSource ["Cockpitdoors_Hide", 0, true];
};
// Medical respawn mover setup
if (_vehicle isKindOf "B_Truck_01_medical_F") then {
	[_vehicle] remoteExec ["D207_fnc_respawntele", 0, true];
};
sleep 0.5;
private _displayName = getText (configFile >> "CfgVehicles" >> _info >> "displayName");
private _chat = format ["You have spawned a %1", _displayName];
systemChat _chat;