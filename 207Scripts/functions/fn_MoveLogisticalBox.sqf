params ["_logibox"];
systemChat "Packing Logistical Box Please wait";
_logiboxPos = getPos _logibox;
sleep 0.5;
_logibox hideObjectGlobal true;
sleep 0.5;
_logiboxmover = [[_logibox, "TOP"], "B_Slingload_01_Cargo_F", 1, [0,0,0], (0),{0},false] call BIS_fnc_spawnObjects;
_MoverBox = _logiboxmover select 0;
_MoverBox allowDamage false;
sleep 0.5;
clearItemCargoGlobal _MoverBox;
clearMagazineCargoGlobal _MoverBox;
clearBackpackCargoGlobal _MoverBox;
clearWeaponCargoGlobal _MoverBox;
[_MoverBox, -1] remoteExeccall ["ace_cargo_fnc_setSize", 0];
[_MoverBox, -1] remoteExeccall ["ace_cargo_fnc_setSpace", 0];
_MoverBoxACT = ["MoverBox", "<t color='#013DB7'>UnPack Logistical Box</t>","",{[_target, 1] spawn D207_fnc_UnPackLogisticalBox;}, {true}, {}, [], [0, 0, 0.3], 7] call ace_interact_menu_fnc_createAction;
[_MoverBox, 0, [], _MoverBoxACT] remoteExec ["ace_interact_menu_fnc_addActionToObject", 0];
_FoxtrotACT = ["FoxtrotBox", "<t color='#FF0000'>Foxtrot</t>","",{[_target, 1] spawn D207_fnc_UnPackLogisticalBox;}, {true}] call ace_interact_menu_fnc_createAction;
[_MoverBox, 0, ["MoverBox"], _FoxtrotACT] remoteExec ["ace_interact_menu_fnc_addActionToObject", 0, true];
_HawkeyeACT = ["HawkeyeBox", "<t color='#00FFFF'>Hawkeye</t>","",{[_target, 2] spawn D207_fnc_UnPackLogisticalBox;}, {true}] call ace_interact_menu_fnc_createAction;
[_MoverBox, 0, ["MoverBox"], _HawkeyeACT] remoteExec ["ace_interact_menu_fnc_addActionToObject", 0, true];
deleteVehicle _logibox;
sleep 0.5;
_MoverBox enableSimulation true;
_MoverBox setPos _logiboxPos;
systemChat "Logistical Box has been packed and is good to be moved";














