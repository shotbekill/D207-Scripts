params ["_BoxPos"];
_BaseboxBig = "Land_Boxloader_Crate_1" createVehicle _BoxPos;
[_BaseboxBig, 0] call ace_cargo_fnc_setSpace;
if (isNil "BoxSupplynamenumber") then {BoxSupplynamenumber = 1;} else {BoxSupplynamenumber = BoxSupplynamenumber + 1;};
publicVariable "BoxSupplynamenumber";
_BoxSupplynumberadd = BoxSupplynamenumber;
_BoxSupplyname = format ["BoxSupplynumber_%1",_BoxSupplynumberadd];
missionNamespace setVariable [_BoxSupplyname, 14, true];

_D207OP = ["D207OP", "<t color='#207207'>D207 OpDems</t>","",{nil}, {true}, {}, [], [0, 0, 1], 3] call ace_interact_menu_fnc_createAction;
[_BaseboxBig, 0, [], _D207OP]  call ace_interact_menu_fnc_addActionToObject;

_Alpha = ["Alpha", "<t color='#0963c2'>Alpha Box</t>","",
{_Supplynumber = missionNamespace getVariable (_this select 2 select 0); missionNamespace setVariable [(_this select 2 select 0), _Supplynumber - 2, true]; player spawn D207_fnc_OpAlpha;}, 
{missionNamespace getVariable (_this select 2 select 0) > 1}, {}, [_BoxSupplyname]] call ace_interact_menu_fnc_createAction;
[_BaseboxBig, 0, ["D207OP"], _Alpha]  call ace_interact_menu_fnc_addActionToObject;

_Bravo = ["Bravo", "<t color='#0963c2'>Bravo Box</t>","",
{_Supplynumber = missionNamespace getVariable (_this select 2 select 0); missionNamespace setVariable [(_this select 2 select 0), _Supplynumber - 2, true]; player spawn D207_fnc_OpBravo;}, 
{missionNamespace getVariable (_this select 2 select 0) > 1}, {}, [_BoxSupplyname]] call ace_interact_menu_fnc_createAction;
[_BaseboxBig, 0, ["D207OP"], _Bravo]  call ace_interact_menu_fnc_addActionToObject;

_Charlie = ["Charlie", "<t color='#0963c2'>Charlie Box</t>","",
{_Supplynumber = missionNamespace getVariable (_this select 2 select 0); missionNamespace setVariable [(_this select 2 select 0), _Supplynumber - 2, true]; player spawn D207_fnc_OpCharlie;}, 
{missionNamespace getVariable (_this select 2 select 0) > 1}, {}, [_BoxSupplyname]] call ace_interact_menu_fnc_createAction;
[_BaseboxBig, 0, ["D207OP"], _Charlie]  call ace_interact_menu_fnc_addActionToObject;

_Reaper = ["Reaper", "<t color='#0963c2'>Reaper Box</t>","",
{_Supplynumber = missionNamespace getVariable (_this select 2 select 0); missionNamespace setVariable [(_this select 2 select 0), _Supplynumber - 2, true]; player spawn D207_fnc_OpReaper;}, 
{missionNamespace getVariable (_this select 2 select 0) > 1}, {}, [_BoxSupplyname]] call ace_interact_menu_fnc_createAction;
[_BaseboxBig, 0, ["D207OP"], _Reaper]  call ace_interact_menu_fnc_addActionToObject;

_PlatHQ = ["PlatHQ", "<t color='#0963c2'>PlatHQ</t>","",
{_Supplynumber = missionNamespace getVariable (_this select 2 select 0); missionNamespace setVariable [(_this select 2 select 0), _Supplynumber - 2, true]; player spawn D207_fnc_PlatHQfull;},
{missionNamespace getVariable (_this select 2 select 0) > 1}, {}, [_BoxSupplyname]] call ace_interact_menu_fnc_createAction;
[_BaseboxBig, 0, ["D207OP"], _PlatHQ]  call ace_interact_menu_fnc_addActionToObject;

_Ghost = ["Ghost", "<t color='#300ba4'>Ghost</t>","",
{_Supplynumber = missionNamespace getVariable (_this select 2 select 0); missionNamespace setVariable [(_this select 2 select 0), _Supplynumber - 1, true]; player spawn D207_fnc_Ghost;},
{missionNamespace getVariable (_this select 2 select 0) > 1}, {}, [_BoxSupplyname]] call ace_interact_menu_fnc_createAction;
[_BaseboxBig, 0, ["D207OP"], _Ghost]  call ace_interact_menu_fnc_addActionToObject;

_Grenades = ["Grenades", "<t color='#300ba4'>Grenades Resupply</t>","",
{_Supplynumber = missionNamespace getVariable (_this select 2 select 0); missionNamespace setVariable [(_this select 2 select 0), _Supplynumber - 1, true]; player spawn D207_fnc_Grenades;},
{missionNamespace getVariable (_this select 2 select 0) > 0}, {}, [_BoxSupplyname]] call ace_interact_menu_fnc_createAction;
[_BaseboxBig, 0, ["D207OP"], _Grenades]  call ace_interact_menu_fnc_addActionToObject;

_AAAmmo = ["AAAmmo", "<t color='#300ba4'>AA Ammo Resupply</t>","",
{_Supplynumber = missionNamespace getVariable (_this select 2 select 0); missionNamespace setVariable [(_this select 2 select 0), _Supplynumber - 1, true]; player spawn D207_fnc_AABox;},
{missionNamespace getVariable (_this select 2 select 0) > 0}, {}, [_BoxSupplyname]] call ace_interact_menu_fnc_createAction;
[_BaseboxBig, 0, ["D207OP"], _AAAmmo]  call ace_interact_menu_fnc_addActionToObject;

_Medic = ["Medic", "<t color='#c52c2c'>Medic Box</t>","",
{_Supplynumber = missionNamespace getVariable (_this select 2 select 0); missionNamespace setVariable [(_this select 2 select 0), _Supplynumber - 1, true]; player spawn D207_fnc_Medic;}, 
{missionNamespace getVariable (_this select 2 select 0) > 0}, {}, [_BoxSupplyname]] call ace_interact_menu_fnc_createAction;
[_BaseboxBig, 0, ["D207OP"], _Medic]  call ace_interact_menu_fnc_addActionToObject;

_Doctor = ["Doctor", "<t color='#c52c2c'>Doctor</t>","",
{_Supplynumber = missionNamespace getVariable (_this select 2 select 0); missionNamespace setVariable [(_this select 2 select 0), _Supplynumber - 1, true]; player spawn D207_fnc_Doctor;},
{missionNamespace getVariable (_this select 2 select 0) > 0}, {}, [_BoxSupplyname]] call ace_interact_menu_fnc_createAction;
[_BaseboxBig, 0, ["D207OP"], _Doctor]  call ace_interact_menu_fnc_addActionToObject;

_Track = ["Track", "<t color='#dee951'>Track</t>","",
{_Supplynumber = missionNamespace getVariable (_this select 2 select 0); missionNamespace setVariable [(_this select 2 select 0), _Supplynumber - 1, true]; "ACE_Track" createVehicle position player;}, 
{missionNamespace getVariable (_this select 2 select 0) > 0}, {}, [_BoxSupplyname]] call ace_interact_menu_fnc_createAction;
[_BaseboxBig, 0, ["D207OP"], _Track]  call ace_interact_menu_fnc_addActionToObject;

_Wheel = ["Wheel", "<t color='#dee951'>Wheel</t>","",
{_Supplynumber = missionNamespace getVariable (_this select 2 select 0); missionNamespace setVariable [(_this select 2 select 0), _Supplynumber - 1, true]; "ACE_Wheel" createVehicle position player;}, 
{missionNamespace getVariable (_this select 2 select 0) > 0}, {}, [_BoxSupplyname]] call ace_interact_menu_fnc_createAction;
[_BaseboxBig, 0, ["D207OP"], _Wheel]  call ace_interact_menu_fnc_addActionToObject;