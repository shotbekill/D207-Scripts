closeDialog 1;
createDialog "VehicleSpawner";
_ctrl = (findDisplay 8100) displayCtrl 1500;
if (D207_VehicleSpawnerType == 1) then {
	{
		_ctrl lbAdd getText (configFile >>  "CfgVehicles" >> _X >> "displayName");
		_ctrl lbSetPicture [_foreachindex,getText (configFile >> "CfgVehicles" >> _x >> "picture")];
		_ctrl lbSetData [_foreachindex, _x];
	} forEach D207_VehicleListPlatoon;
};
if (D207_VehicleSpawnerType == 2) then {
	{
		_ctrl lbAdd getText (configFile >>  "CfgVehicles" >> _X >> "displayName");
		_ctrl lbSetPicture [_foreachindex,getText (configFile >> "CfgVehicles" >> _x >> "picture")];
		_ctrl lbSetData [_foreachindex, _x];
	} forEach D207_VehicleListFoxtrot;
};
if (D207_VehicleSpawnerType == 3) then {
	{
		_ctrl lbAdd getText (configFile >>  "CfgVehicles" >> _X >> "displayName");
		_ctrl lbSetPicture [_foreachindex,getText (configFile >> "CfgVehicles" >> _x >> "picture")];
		_ctrl lbSetData [_foreachindex, _x];
	} forEach D207_VehicleListHawkeye;
};
if (D207_VehicleSpawnerType == 4) then {
	{
		_ctrl lbAdd getText (configFile >>  "CfgVehicles" >> _X >> "displayName");
		_ctrl lbSetPicture [_foreachindex,getText (configFile >> "CfgVehicles" >> _x >> "picture")];
		_ctrl lbSetData [_foreachindex, _x];
	} forEach D207_VehicleListDrone;
};
_ctrl lbSetCurSel 0;