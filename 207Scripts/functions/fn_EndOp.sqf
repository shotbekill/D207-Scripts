if (isServer) then {
	[West, "All Objectives Done."] call ocap_fnc_exportData;
	sleep 5;
	"end1" call BIS_fnc_endMissionServer;
};