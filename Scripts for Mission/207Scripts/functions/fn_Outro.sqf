missionNamespace setVariable ["EndOp", false, true];
private _CallerId = clientOwner;
remoteExec ["Outro.sqf", -_CallerId];
_Outro = execVM "Outro.sqf";
waitUntil {
	scriptDone _Outro
};
remoteExec ["D207_fnc_EndOp", 2];