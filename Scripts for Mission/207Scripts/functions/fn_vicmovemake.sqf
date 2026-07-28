params [
	["_mode", "", [""]],
	["_data", objNull]
];

switch (_mode) do
{
	case "CREATE":
	{
		if (!isServer) exitWith {};
		private _caller = _data;
		if (isNull _caller) exitWith {};
		if (!isPlayer _caller) exitWith {};
		if (isRemoteExecuted && {remoteExecutedOwner != owner _caller}) exitWith {};
		private _spawnPosition = _caller getRelPos [1.5, 0];
		private _packerbox = createVehicle ["BL_Crate_D207_VPacker",_spawnPosition,[],0,"CAN_COLLIDE"];
		_packerbox setDir getDir _caller;
		/*
			Add ACE actions on every client.
			Using the box as the JIP ID removes the saved
			remoteExec automatically when the box is deleted.
		*/
		["ADD_ACTIONS", _packerbox] remoteExec ["D207_fnc_vicmovemake",0,_packerbox];
	};
	case "ADD_ACTIONS":
	{
		if (!hasInterface) exitWith {};
		private _packerbox = _data;
		if (isNull _packerbox) exitWith {};
		if (_packerbox getVariable ["D207_vehiclePackerActionsAdded",false]) exitWith {};
		_packerbox setVariable ["D207_vehiclePackerActionsAdded",true];
		/*
			Land vehicle action.
		*/
		private _landAction = ["D207_PackLandVehicle","Pack Nearest Land Vehicle","",
			{
				params ["_target","_player","_parameters"];
				[_target,_player,"LAND"] remoteExec ["D207_fnc_vicmove",2];
			},
			{
				params ["_target","_player","_parameters"];
				alive _target && {_player distance _target <= 5} && {[_player,_target,[]] call ace_common_fnc_canInteractWith} && {!(_target getVariable ["D207_packBusy",false])}
			},{},[],[0, 0, 0.7],7
		] call ace_interact_menu_fnc_createAction;

		[_packerbox,0,[],_landAction] call ace_interact_menu_fnc_addActionToObject;
		/*
			Airframe action.
		*/
		private _airAction = ["D207_PackAirframe","Pack Nearest Airframe","",
			{
				params ["_target","_player","_parameters"];
				[_target,_player,"AIR"] remoteExec ["D207_fnc_vicmove",2];
			},
			{
				params ["_target","_player","_parameters"];
				alive _target && {_player distance _target <= 5} && {[_player,_target,[]] call ace_common_fnc_canInteractWith} && {!(_target getVariable ["D207_packBusy",false])}
			},{},[],[0, 0, 1],7
		] call ace_interact_menu_fnc_createAction;

		[_packerbox,0,[],_airAction] call ace_interact_menu_fnc_addActionToObject;
	};
};