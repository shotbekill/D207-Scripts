params [
	["_mode", "", [""]],
	["_data1", objNull],
	["_data2", objNull]
];
switch (_mode) do
{
	case "MESSAGE":
	{
		if (!hasInterface) exitWith {};
		private _message = _data1;
		if (_message isEqualType "") then
		{systemChat _message;};
	};
	case "ADD_ACTION":
	{
		if (!hasInterface) exitWith {};
		private _packbox = _data1;
		if (isNull _packbox) exitWith {};
		if (_packbox getVariable ["D207_unpackActionAdded",false]) exitWith {};
		_packbox setVariable ["D207_unpackActionAdded",true];
		private _displayName = _packbox getVariable ["D207_packedDisplayName","Vehicle"];
		private _actionName = format ["Unpack %1",_displayName];
		private _unpackAction = ["D207_UnpackPackedVehicle",_actionName,"",
			{
				params ["_target","_player","_parameters"];
				["UNPACK",_target,_player] remoteExec ["D207_fnc_unboxvic",2];
			},
			{
				params ["_target","_player","_parameters"];
				alive _target &&
				{_player distance _target <= 8} &&
				{abs speed _target <= 1} &&
				{isNull attachedTo _target} &&
				{!(_target getVariable ["D207_unpackBusy",false])} &&
				{[_player,_target,[]] call ace_common_fnc_canInteractWith}
			},{},[],[0, 0, 0.5],8
		] call ace_interact_menu_fnc_createAction;
		[_packbox,0,[],_unpackAction] call ace_interact_menu_fnc_addActionToObject;
	};
	case "UNPACK":
	{
		if (!isServer) exitWith {};
		private _packbox = _data1;
		private _caller = _data2;
		if (isNull _packbox) exitWith {};
		if (isNull _caller) exitWith {};
		if (isRemoteExecuted && {remoteExecutedOwner != owner _caller}) exitWith {};
		private _sendMessage =
		{
			params ["_message"];
			["MESSAGE",_message] remoteExec ["D207_fnc_unboxvic",owner _caller];
		};
		if (_caller distance _packbox > 10) exitWith {["You are too far away from the transport box."] call _sendMessage;};
		if (_packbox getVariable ["D207_unpackBusy",false]) exitWith {["This vehicle is already being unpacked."] call _sendMessage;};
		_packbox setVariable ["D207_unpackBusy",true,true];
		if (abs speed _packbox > 1) exitWith {_packbox setVariable ["D207_unpackBusy",false,true];["The transport box must be stationary."] call _sendMessage;};
		if (!isNull attachedTo _packbox) exitWith {_packbox setVariable ["D207_unpackBusy",false,true];
		["Unload or detach the transport box first."] call _sendMessage;};
		// Do not unpack while the transport box itself is loaded through Vehicle-in-Vehicle.
		if (!isNull isVehicleCargo _packbox) exitWith {_packbox setVariable ["D207_unpackBusy",false,true];["Unload the transport box from its carrier first."] call _sendMessage;};
		private _victopack = _packbox getVariable ["D207_packedVehicle",objNull];
		if (isNull _victopack) exitWith {_packbox setVariable ["D207_unpackBusy",false,true];["The packed vehicle could not be found."] call _sendMessage;};
		private _displayName = _packbox getVariable ["D207_packedDisplayName","Vehicle"];
		private _packedType = _packbox getVariable ["D207_packedType","LAND"];
		private _boxPosition = getPosATL _packbox;
		private _boxDirection = getDir _packbox;
		private _storedVectorDir = _packbox getVariable ["D207_packedVectorDir",[0, 1, 0]];
		private _storedVectorUp = _packbox getVariable ["D207_packedVectorUp",[0, 0, 1]];
		private _spawnHeight = if (_packedType isEqualTo "AIR") then {0.5} else {0.15};
		[ format ["Unpacking %1.",_displayName]] call _sendMessage;
		deleteVehicle _packbox;
		private _deleteTimeout = time + 2;
		waitUntil{sleep 0.05;isNull _packbox || {time >= _deleteTimeout}};
		// Move the original vehicle back before showing it.
		_victopack setVectorDirAndUp [_storedVectorDir,_storedVectorUp];
		// Use the transport box's current direction so the player can rotate the packed vehicle by moving the box.
		_victopack setDir _boxDirection;
		_victopack setPosATL (_boxPosition vectorAdd [0,0,_spawnHeight]);
		_victopack setVelocity [0, 0, 0];
		// The vehicle is now at the new location. Reveal it only after the move.
		sleep 0.25;
		_victopack hideObjectGlobal false;
		_victopack enableSimulationGlobal true;
		_victopack allowDamage true;
		_victopack setVariable ["D207_isPacked",false,true];
		[ format ["Unpacking of %1 complete.",_displayName]] call _sendMessage;
	};
};