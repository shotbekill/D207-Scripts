params ["_MoverBox", "_MoverBoxtype"];
systemChat "UnPacking Logistical Box Please wait";
__MoverBoxPos = getPos _MoverBox;
_MoverBox hideObjectGlobal true;
sleep 0.5;
if (_MoverBoxtype == 1) then {logiboxspawn = [[_MoverBox, "TOP"], "Land_RepairDepot_01_green_F", 1, [0,5,0], (0),{0},false] call BIS_fnc_spawnObjects;};
if (_MoverBoxtype == 2) then {logiboxspawn = [[_MoverBox, "TOP"], "Land_RepairDepot_01_tan_F", 1, [0,5,0], (0),{0},false] call BIS_fnc_spawnObjects;};
_logibox = logiboxspawn select 0;
_logibox allowDamage false;
sleep 0.5;
deleteVehicle _MoverBox;
sleep 0.5;
_logibox enableSimulation true;
_logibox setPos __MoverBoxPos;
sleep 1.5;
_logibox enableSimulation false;
[_logibox,"207Scripts\LogisticalResupplyScript.sqf"] remoteExec ["execVM", 0, true];
systemChat "Logistical Box has been Unpacked and is good to go";














