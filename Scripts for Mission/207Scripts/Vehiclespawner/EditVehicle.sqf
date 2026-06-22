_box = SpawnBoxLOC;
private _checkPosition = _box modelToWorld [0, 20, 0];
private _vehicles = nearestObjects [_checkPosition,["LandVehicle", "Air", "Ship"],10];
if (_vehicles isEqualTo []) exitWith {hint "No vehicle in area to edit.";};
private _vehicleToEdit = _vehicles select 0;
if (isNull _vehicleToEdit) exitWith {hint "No vehicle in area to edit.";};
closeDialog 1;
sleep 0.5;
[_vehicleToEdit] call D207_fnc_openVehicleEditor;