private ["_Arsenalbox"];
params ["_Arsenalbox"];
waitUntil {!isNil "Startup"};
if (hasInterface) then {
	waitUntil {missionNamespace getVariable "Startup"};
	[_Arsenalbox, [],true] call ace_arsenal_fnc_initBox;
	[_Arsenalbox, D207_guns,true] call ace_arsenal_fnc_addVirtualItems;
	[_Arsenalbox, D207_Handgun,true] call ace_arsenal_fnc_addVirtualItems;
	[_Arsenalbox, D207_lunchers,true] call ace_arsenal_fnc_addVirtualItems;
	[_Arsenalbox, D207_unf,true] call ace_arsenal_fnc_addVirtualItems;
	[_Arsenalbox, D207_Vests,true] call ace_arsenal_fnc_addVirtualItems;
	[_Arsenalbox, D207_Backpacks,true] call ace_arsenal_fnc_addVirtualItems;
	[_Arsenalbox, D207_Hats,true] call ace_arsenal_fnc_addVirtualItems;
	[_Arsenalbox, D207_eyewear,true] call ace_arsenal_fnc_addVirtualItems;
	[_Arsenalbox, D207_Atmet,true] call ace_arsenal_fnc_addVirtualItems;
	[_Arsenalbox, D207_Ammo,true] call ace_arsenal_fnc_addVirtualItems;
	[_Arsenalbox, D207_Gen,true] call ace_arsenal_fnc_addVirtualItems;
	[_Arsenalbox, D207_Med,true] call ace_arsenal_fnc_addVirtualItems;
	[_Arsenalbox, D207_Mines,true] call ace_arsenal_fnc_addVirtualItems;
	[_Arsenalbox, D207_misc,true] call ace_arsenal_fnc_addVirtualItems;
	[_Arsenalbox, D207_PHat,true] call ace_arsenal_fnc_addVirtualItems;
	[_Arsenalbox, D207_Medlvl1,true] call ace_arsenal_fnc_addVirtualItems;
	[_Arsenalbox, D207_Medlvl2,true] call ace_arsenal_fnc_addVirtualItems;
	[_Arsenalbox, D207_EOD,true] call ace_arsenal_fnc_addVirtualItems;
	[_Arsenalbox, D207_ENGLVL1,true] call ace_arsenal_fnc_addVirtualItems;
	[_Arsenalbox, D207_Drones,true] call ace_arsenal_fnc_addVirtualItems;
	__Arsenalupdate = ["Core1", "<t color='#9204c9'>Update Arsenal</t>","",{[_this select 0] spawn D207_fnc_UpdateArsenalitems;}, {true}, {}, [_Arsenalbox]] call ace_interact_menu_fnc_createAction;
	[_Arsenalbox, 0, ["ACE_MainActions"], __Arsenalupdate]  call ace_interact_menu_fnc_addActionToObject;
};
/*
	if ([player,1] call ace_common_fnc_isMedic) then {[_Arsenalbox, D207_Medlvl1,true] call ace_arsenal_fnc_addVirtualItems;};
	if ([player,2] call ace_common_fnc_isMedic) then {[_Arsenalbox, D207_Medlvl2,true] call ace_arsenal_fnc_addVirtualItems;};
	if ([player] call ace_common_fnc_isEOD) then {[_Arsenalbox, D207_EOD,true] call ace_arsenal_fnc_addVirtualItems;};
	if ([player,1] call ace_common_fnc_isEngineer) then {[_Arsenalbox, D207_ENGLVL1,true] call ace_arsenal_fnc_addVirtualItems;};
	if ([player,2] call ace_common_fnc_isEngineer) then {[_Arsenalbox, D207_ENGLVL2,true] call ace_arsenal_fnc_addVirtualItems;};
*/