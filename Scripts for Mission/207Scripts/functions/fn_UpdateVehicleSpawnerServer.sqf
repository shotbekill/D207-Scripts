params [
    ["_operation", "", [""]],
    ["_value", 0],
    ["_caller", objNull, [objNull]]
];

if (!isServer) exitWith {};
if (isNull _caller || {!isPlayer _caller}) exitWith {};
if (isRemoteExecuted && {remoteExecutedOwner != owner _caller}) exitWith {};
if (isNull (getAssignedCuratorLogic _caller)) exitWith {};

private _setTicket = {
    params ["_name", "_ticketValue"];
    private _safeValue = (round _ticketValue) max 0 min 999;
    missionNamespace setVariable [_name, _safeValue, true];
};

switch (toUpper _operation) do {
    case "LOCK_PLATOON": {missionNamespace setVariable ["D207_VehiclePlatoon", _value, true];};
    case "LOCK_FOXTROT": {missionNamespace setVariable ["D207_VehicleFoxtrot", _value, true];};
    case "LOCK_HAWKEYE": {missionNamespace setVariable ["D207_VehicleHawkeye", _value, true];};
    case "LOCK_DRONE": {missionNamespace setVariable ["D207_VehicleDrone", _value, true];};
    case "LOCK_ALL": {
        {
            missionNamespace setVariable [_x, _value, true];
        } forEach ["D207_VehiclePlatoon", "D207_VehicleFoxtrot", "D207_VehicleHawkeye", "D207_VehicleDrone"];
    };
    case "TICKETS_PLATOON": {["D207_PlatoonTickets", _value] call _setTicket;};
    case "TICKETS_FOXTROT": {["D207_FoxtrotTickets", _value] call _setTicket;};
    case "TICKETS_HAWKEYE": {["D207_HawkeyeTickets", _value] call _setTicket;};
    case "TICKETS_DRONE": {["D207_DroneTickets", _value] call _setTicket;};
    case "TICKETS_ALL": {
        private _safeValue = (round _value) max 0 min 999;
        {
            missionNamespace setVariable [_x, _safeValue, true];
        } forEach ["D207_PlatoonTickets", "D207_FoxtrotTickets", "D207_HawkeyeTickets", "D207_DroneTickets"];
    };
    case "ADD_PLATOON";
    case "ADD_FOXTROT";
    case "ADD_HAWKEYE";
    case "ADD_DRONE": {
        if !(_value isEqualType "") exitWith {};
        if !(isClass (configFile >> "CfgVehicles" >> _value)) exitWith {};
        private _map = createHashMapFromArray [
            ["ADD_PLATOON", "D207_VehicleListPlatoon"],
            ["ADD_FOXTROT", "D207_VehicleListFoxtrot"],
            ["ADD_HAWKEYE", "D207_VehicleListHawkeye"],
            ["ADD_DRONE", "D207_VehicleListDrone"]
        ];
        private _variableName = _map get (toUpper _operation);
        private _list = + (missionNamespace getVariable [_variableName, []]);
        if !(_value in _list) then {
            _list pushBack _value;
            missionNamespace setVariable [_variableName, _list, true];
        };
    };
};
