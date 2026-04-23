params ["_box"];
_moverw = ["MoveRespawnW", "Move Respawn now","",{call D207_fnc_Moverespawnnow;}, {true}] call ace_interact_menu_fnc_createAction;
[_box, 0, ["ACE_MainActions"], _moverw]  call ace_interact_menu_fnc_addActionToObject;