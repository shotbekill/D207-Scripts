_ctrlPLT = (findDisplay 8200) displayCtrl 1000;
_ctrlFOX = (findDisplay 8200) displayCtrl 1001;
_ctrlHAW = (findDisplay 8200) displayCtrl 1002;
_ctrlDrone = (findDisplay 8200) displayCtrl 1003;
_ctrlPLTTicket = (findDisplay 8200) displayCtrl 1400;
_ctrlFOXTicket = (findDisplay 8200) displayCtrl 1402;
_ctrlHAWTicket = (findDisplay 8200) displayCtrl 1401;
_ctrlDroneTicket = (findDisplay 8200) displayCtrl 1403;
_ctrlTicketAll = (findDisplay 8200) displayCtrl 1404;

if (isNil "D207_CanSpawnCode") then {D207_CanSpawnCode = 0;};
if (isNil "D207_Platoon") then {D207_Platoon = 0;};
if (isNil "D207_Foxtrot") then {D207_Foxtrot = 0;};
if (isNil "D207_Hawkeye") then {D207_Hawkeye = 0;};
if (isNil "D207_Drone") then {D207_Drone = 0;};
if (isNil "D207_CanSpawnAll") then {D207_CanSpawnAll = 0;};
if (isNil "D207_Tickets") then {D207_Tickets = 0;};

if (D207_CanSpawnCode == 1) then {
	if (D207_VehiclePlatoon) then {_ctrlPLT ctrlSetBackgroundColor [0.7, 0, 0, 0.5];} else {_ctrlPLT ctrlSetBackgroundColor [0, 0.7, 0, 0.5];};
	if (D207_VehicleFoxtrot) then {_ctrlFOX ctrlSetBackgroundColor [0.7, 0, 0, 0.5];} else {_ctrlFOX ctrlSetBackgroundColor [0, 0.7, 0, 0.5];};
	if (D207_VehicleHawkeye) then {_ctrlHAW ctrlSetBackgroundColor [0.7, 0, 0, 0.5];} else {_ctrlHAW ctrlSetBackgroundColor [0, 0.7, 0, 0.5];};
	if (D207_VehicleDrone) then {_ctrlDrone ctrlSetBackgroundColor [0.7, 0, 0, 0.5];} else {_ctrlDrone ctrlSetBackgroundColor [0, 0.7, 0, 0.5];};
	_PLTTickets = format ["%1",D207_PlatoonTickets];
	_ctrlPLTTicket ctrlSetText _PLTTickets;
	_FOXTicket = format ["%1",D207_FoxtrotTickets];
	_ctrlFOXTicket ctrlSetText _FOXTicket;
	_HAWTicket = format ["%1",D207_HawkeyeTickets];
	_ctrlHAWTicket ctrlSetText _HAWTicket;
	_DroneTicket = format ["%1",D207_DroneTickets];
	_ctrlDroneTicket ctrlSetText _DroneTicket;
};
if (D207_Platoon == 1) then {missionNamespace setVariable ['D207_VehiclePlatoon', false, true];_ctrlPLT ctrlSetBackgroundColor [0, 0.7, 0, 0.5];};
if (D207_Platoon == 2) then {missionNamespace setVariable ['D207_VehiclePlatoon', true, true];_ctrlPLT ctrlSetBackgroundColor [0.7, 0, 0, 0.5];};
if (D207_Foxtrot == 1) then {missionNamespace setVariable ['D207_VehicleFoxtrot', false, true];_ctrlFOX ctrlSetBackgroundColor [0, 0.7, 0, 0.5];};
if (D207_Foxtrot == 2) then {missionNamespace setVariable ['D207_VehicleFoxtrot', true, true];_ctrlFOX ctrlSetBackgroundColor [0.7, 0, 0, 0.5];};
if (D207_Hawkeye == 1) then {missionNamespace setVariable ['D207_VehicleHawkeye', false, true];_ctrlHAW ctrlSetBackgroundColor [0, 0.7, 0, 0.5];};
if (D207_Hawkeye == 2) then {missionNamespace setVariable ['D207_VehicleHawkeye', true, true];_ctrlHAW ctrlSetBackgroundColor [0.7, 0, 0, 0.5];};
if (D207_Drone == 1) then {missionNamespace setVariable ['D207_VehicleDrone', false, true];_ctrlDrone ctrlSetBackgroundColor [0, 0.7, 0, 0.5];};
if (D207_Drone == 2) then {missionNamespace setVariable ['D207_VehicleDrone', true, true];_ctrlDrone ctrlSetBackgroundColor [0.7, 0, 0, 0.5];};
if (D207_CanSpawnAll == 2) then {
	missionNamespace setVariable ['D207_VehiclePlatoon', true, true];
	missionNamespace setVariable ['D207_VehicleFoxtrot', true, true];
	missionNamespace setVariable ['D207_VehicleHawkeye', true, true];
	missionNamespace setVariable ['D207_VehicleDrone', true, true];
	_ctrlPLT ctrlSetBackgroundColor [0.7, 0, 0, 0.5];
	_ctrlFOX ctrlSetBackgroundColor [0.7, 0, 0, 0.5];
	_ctrlHAW ctrlSetBackgroundColor [0.7, 0, 0, 0.5];
	_ctrlDrone ctrlSetBackgroundColor [0.7, 0, 0, 0.5];
};
if (D207_CanSpawnAll == 1) then {
	missionNamespace setVariable ['D207_VehiclePlatoon', false, true];
	missionNamespace setVariable ['D207_VehicleFoxtrot', false, true];
	missionNamespace setVariable ['D207_VehicleHawkeye', false, true];
	missionNamespace setVariable ['D207_VehicleDrone', false, true];
	_ctrlPLT ctrlSetBackgroundColor [0, 0.7, 0, 0.5];
	_ctrlFOX ctrlSetBackgroundColor [0, 0.7, 0, 0.5];
	_ctrlHAW ctrlSetBackgroundColor [0, 0.7, 0, 0.5];
	_ctrlDrone ctrlSetBackgroundColor [0, 0.7, 0, 0.5];
};
if (D207_Tickets == 1) then {
	private _PLTTicketset = parseNumber (ctrlText _ctrlPLTTicket);
	missionNamespace setVariable ["D207_PlatoonTickets", _PLTTicketset, true];
};
if (D207_Tickets == 2) then {
	private _FOXTicketset = parseNumber (ctrlText _ctrlFOXTicket);
	missionNamespace setVariable ["D207_FoxtrotTickets", _FOXTicketset, true];
};
if (D207_Tickets == 3) then {
	private _HAWTicketset = parseNumber (ctrlText _ctrlHAWTicket);
	missionNamespace setVariable ["D207_HawkeyeTickets", _HAWTicketset, true];
};
if (D207_Tickets == 4) then {
	private _DroneTicketset = parseNumber (ctrlText _ctrlDroneTicket);
	missionNamespace setVariable ["D207_DroneTickets", _DroneTicketset, true];
};
if (D207_Tickets == 5) then {
	private _Ticketset = parseNumber (ctrlText _ctrlTicketAll);
	missionNamespace setVariable ["D207_PlatoonTickets", _Ticketset, true];
	missionNamespace setVariable ["D207_FoxtrotTickets", _Ticketset, true];
	missionNamespace setVariable ["D207_HawkeyeTickets", _Ticketset, true];
	missionNamespace setVariable ["D207_DroneTickets", _Ticketset, true];
	_ctrlPLTTicket ctrlSetText str _Ticketset;
	_ctrlFOXTicket ctrlSetText str _Ticketset;
	_ctrlHAWTicket ctrlSetText str _Ticketset;
	_ctrlDroneTicket ctrlSetText str _Ticketset;
};

D207_CanSpawnCode = nil;
D207_Platoon = nil;
D207_Foxtrot = nil;
D207_Hawkeye = nil;
D207_Drone = nil;
D207_CanSpawnAll = nil;
D207_Tickets = nil;