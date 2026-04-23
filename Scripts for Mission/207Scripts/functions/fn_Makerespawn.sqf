params ["_BoxPos"];
_box = "B_Slingload_01_Medevac_F" createVehicle _BoxPos;
[_box] remoteExec ["D207_fnc_respawnadd", 0];