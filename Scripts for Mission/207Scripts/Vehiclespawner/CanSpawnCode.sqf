disableSerialization;
private _display = findDisplay 8200;
if (isNull _display) exitWith {};

private _ctrlPLT = _display displayCtrl 1000;
private _ctrlFOX = _display displayCtrl 1001;
private _ctrlHAW = _display displayCtrl 1002;
private _ctrlDrone = _display displayCtrl 1003;
private _ctrlPLTTicket = _display displayCtrl 1400;
private _ctrlFOXTicket = _display displayCtrl 1402;
private _ctrlHAWTicket = _display displayCtrl 1401;
private _ctrlDroneTicket = _display displayCtrl 1403;
private _ctrlTicketAll = _display displayCtrl 1404;

if (isNil "D207_CanSpawnCode") then {D207_CanSpawnCode = 0;};
if (isNil "D207_Platoon") then {D207_Platoon = 0;};
if (isNil "D207_Foxtrot") then {D207_Foxtrot = 0;};
if (isNil "D207_Hawkeye") then {D207_Hawkeye = 0;};
if (isNil "D207_Drone") then {D207_Drone = 0;};
if (isNil "D207_CanSpawnAll") then {D207_CanSpawnAll = 0;};
if (isNil "D207_Tickets") then {D207_Tickets = 0;};

if (D207_CanSpawnCode == 1) then {
    private _pltLocked = missionNamespace getVariable ["D207_VehiclePlatoon", false];
    private _foxLocked = missionNamespace getVariable ["D207_VehicleFoxtrot", false];
    private _hawLocked = missionNamespace getVariable ["D207_VehicleHawkeye", false];
    private _droneLocked = missionNamespace getVariable ["D207_VehicleDrone", false];
    _ctrlPLT ctrlSetBackgroundColor (if (_pltLocked) then {[0.7,0,0,0.5]} else {[0,0.7,0,0.5]});
    _ctrlFOX ctrlSetBackgroundColor (if (_foxLocked) then {[0.7,0,0,0.5]} else {[0,0.7,0,0.5]});
    _ctrlHAW ctrlSetBackgroundColor (if (_hawLocked) then {[0.7,0,0,0.5]} else {[0,0.7,0,0.5]});
    _ctrlDrone ctrlSetBackgroundColor (if (_droneLocked) then {[0.7,0,0,0.5]} else {[0,0.7,0,0.5]});
    _ctrlPLTTicket ctrlSetText str (missionNamespace getVariable ["D207_PlatoonTickets", 0]);
    _ctrlFOXTicket ctrlSetText str (missionNamespace getVariable ["D207_FoxtrotTickets", 0]);
    _ctrlHAWTicket ctrlSetText str (missionNamespace getVariable ["D207_HawkeyeTickets", 0]);
    _ctrlDroneTicket ctrlSetText str (missionNamespace getVariable ["D207_DroneTickets", 0]);
};

private _send = {
    params ["_op", "_value"];
    [_op, _value, player] remoteExecCall ["D207_fnc_UpdateVehicleSpawnerServer", 2];
};

if (D207_Platoon == 1) then {["LOCK_PLATOON", false] call _send; _ctrlPLT ctrlSetBackgroundColor [0,0.7,0,0.5];};
if (D207_Platoon == 2) then {["LOCK_PLATOON", true] call _send; _ctrlPLT ctrlSetBackgroundColor [0.7,0,0,0.5];};
if (D207_Foxtrot == 1) then {["LOCK_FOXTROT", false] call _send; _ctrlFOX ctrlSetBackgroundColor [0,0.7,0,0.5];};
if (D207_Foxtrot == 2) then {["LOCK_FOXTROT", true] call _send; _ctrlFOX ctrlSetBackgroundColor [0.7,0,0,0.5];};
if (D207_Hawkeye == 1) then {["LOCK_HAWKEYE", false] call _send; _ctrlHAW ctrlSetBackgroundColor [0,0.7,0,0.5];};
if (D207_Hawkeye == 2) then {["LOCK_HAWKEYE", true] call _send; _ctrlHAW ctrlSetBackgroundColor [0.7,0,0,0.5];};
if (D207_Drone == 1) then {["LOCK_DRONE", false] call _send; _ctrlDrone ctrlSetBackgroundColor [0,0.7,0,0.5];};
if (D207_Drone == 2) then {["LOCK_DRONE", true] call _send; _ctrlDrone ctrlSetBackgroundColor [0.7,0,0,0.5];};

if (D207_CanSpawnAll == 1) then {
    ["LOCK_ALL", false] call _send;
    {_x ctrlSetBackgroundColor [0,0.7,0,0.5];} forEach [_ctrlPLT,_ctrlFOX,_ctrlHAW,_ctrlDrone];
};
if (D207_CanSpawnAll == 2) then {
    ["LOCK_ALL", true] call _send;
    {_x ctrlSetBackgroundColor [0.7,0,0,0.5];} forEach [_ctrlPLT,_ctrlFOX,_ctrlHAW,_ctrlDrone];
};

private _parseTicket = {params ["_control"]; (round parseNumber (ctrlText _control)) max 0 min 999};
if (D207_Tickets == 1) then {["TICKETS_PLATOON", [_ctrlPLTTicket] call _parseTicket] call _send;};
if (D207_Tickets == 2) then {["TICKETS_FOXTROT", [_ctrlFOXTicket] call _parseTicket] call _send;};
if (D207_Tickets == 3) then {["TICKETS_HAWKEYE", [_ctrlHAWTicket] call _parseTicket] call _send;};
if (D207_Tickets == 4) then {["TICKETS_DRONE", [_ctrlDroneTicket] call _parseTicket] call _send;};
if (D207_Tickets == 5) then {
    private _ticketValue = [_ctrlTicketAll] call _parseTicket;
    ["TICKETS_ALL", _ticketValue] call _send;
    {_x ctrlSetText str _ticketValue;} forEach [_ctrlPLTTicket,_ctrlFOXTicket,_ctrlHAWTicket,_ctrlDroneTicket];
};

D207_CanSpawnCode = nil;
D207_Platoon = nil;
D207_Foxtrot = nil;
D207_Hawkeye = nil;
D207_Drone = nil;
D207_CanSpawnAll = nil;
D207_Tickets = nil;
