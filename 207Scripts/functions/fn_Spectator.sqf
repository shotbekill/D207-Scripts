params ["_Player"];

_actionId = Player addAction ["Spectator", {["Initialize", [player]] call BIS_fnc_EGSpectator;}];

[] spawn {
	while{true}do{
		waitUntil {!isNull findDisplay 49};
		["Terminate"] call BIS_fnc_EGSpectator;
		uisleep 3;
	};
};
waitUntil {
	sleep 1;
	!alive Player;
};
player removeAction _actionId;