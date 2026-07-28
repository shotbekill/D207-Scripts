if (isServer) then {
	[West, "All Objectives Done."] call ocap_fnc_exportData;
	sleep 1;
	"end1" call BIS_fnc_endMissionServer;
};