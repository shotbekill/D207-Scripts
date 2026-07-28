private _uav = getConnectedUAV player;
if (isNull _uav) exitWith {
	hint "You are not connected to a UAV.";
};
if !(unitIsUAV _uav) exitWith {
	hint "The connected vehicle is not a UAV.";
};
// Request the ownership transfer from the server.
[_uav,player] remoteExecCall ["D207_fnc_ClaimUAV",2];