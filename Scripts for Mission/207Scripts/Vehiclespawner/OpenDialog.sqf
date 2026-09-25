closeDialog 1;
if !(createDialog "VehicleSpawner") exitWith {hint "Unable to open the vehicle spawner dialog.";};

private _display = findDisplay 8100;
if (isNull _display) exitWith {};
private _ctrl = _display displayCtrl 1500;
if (isNull _ctrl) exitWith {};

private _type = missionNamespace getVariable ["D207_VehicleSpawnerType", 0];
private _vehicles = switch (_type) do {
    case 1: {missionNamespace getVariable ["D207_VehicleListPlatoon", []]};
    case 2: {missionNamespace getVariable ["D207_VehicleListFoxtrot", []]};
    case 3: {missionNamespace getVariable ["D207_VehicleListHawkeye", []]};
    case 4: {missionNamespace getVariable ["D207_VehicleListDrone", []]};
    default {[]};
};

{
    private _cfg = configFile >> "CfgVehicles" >> _x;
    if (isClass _cfg) then {
        private _index = _ctrl lbAdd getText (_cfg >> "displayName");
        _ctrl lbSetPicture [_index, getText (_cfg >> "picture")];
        _ctrl lbSetData [_index, _x];
    };
} forEach _vehicles;

if ((lbSize _ctrl) > 0) then {
    _ctrl lbSetCurSel 0;
};
