if (isServer) then {
missionNamespace setVariable ["Gameon", false, true];
};
if (hasInterface) then {
"ALL Stop" hintC [
"Stop where you are.",
"Don't do any thing with any Objects.",
"You may heal your self but not anyone else.",
"Please Wait for Game On before doing anything."
];
hintC_EH = findDisplay 72 displayAddEventHandler ["Unload", { 
	_this spawn { 
		_this select 0 displayRemoveEventHandler ["Unload", hintC_EH]; 
		hintSilent ""; 
	}; 
}];
};