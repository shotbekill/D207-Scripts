params [
	["_uav", objNull, [objNull]],
	["_controller", objNull, [objNull]]
];

if (!isServer) exitWith {};
if (isNull _uav) exitWith {};
if !(unitIsUAV _uav) exitWith {};

// Start no-fuel / dead UAV delete monitor once per UAV
if !(_uav getVariable ["D207_UAVFuelMonitorStarted", false]) then {
	_uav setVariable ["D207_UAVFuelMonitorStarted", true, true];
	[_uav] spawn {
		params ["_uav"];
		private _noFuelTime = 0;
		private _deadTime = 0;
		while { !isNull _uav } do {
			sleep 1;
			if (isNull _uav) exitWith {};
			// If UAV is dead, start dead timer
			if !(alive _uav) then {
				_deadTime = _deadTime + 1;
			} else {
				_deadTime = 0;
			};
			// If UAV has no fuel, start no-fuel timer
			if ((fuel _uav) <= 0) then {
				_noFuelTime = _noFuelTime + 1;
			} else {
				_noFuelTime = 0;
			};
			// Delete if dead for X seconds OR no fuel for X seconds
			if (_deadTime >= 60 || { _noFuelTime >= 60 }) exitWith {
				private _uavGroup = group _uav;
				// Tell the group to delete itself once it has no units left
				if (!isNull _uavGroup) then {
					_uavGroup deleteGroupWhenEmpty true;
				};
				// Delete UAV crew first
				{
					deleteVehicle _x;
				} forEach crew _uav;
				// Delete the UAV itself
				if (!isNull _uav) then {
					deleteVehicle _uav;
				};
				// Backup group cleanup check
				[_uavGroup] spawn {
					params ["_uavGroup"];
					sleep 1;
					if (!isNull _uavGroup && { count units _uavGroup == 0 }) then {
						deleteGroup _uavGroup;
					};
				};
			};
		};
	};
};
// Stop here if no connecting player was passed
if (isNull _controller) exitWith {};
private _requestOwner = remoteExecutedOwner;
/*
	Security check.
	The client sending the request must own the player object supplied in _controller.
*/
if (isRemoteExecuted && {_requestOwner != owner _controller}) exitWith {};
private _controllerUID = getPlayerUID _controller;
if (_controllerUID isEqualTo "") exitWith {};
// Check whether this UAV already has an owner.
private _ownerUID = _uav getVariable ["D207_UAVOwnerUID",""];

// No current owner: the first player who connected becomes the owner.

if (_ownerUID isEqualTo "") exitWith {
	[_uav,_controller] call D207_fnc_SetUAVOwner;
	[format ["You are now the owner of %1.",groupId group _uav]] remoteExecCall ["D207_fnc_UAVHint",owner _controller];
};
// The actual owning player connecting again does nothing.
if (_ownerUID isEqualTo _controllerUID) exitWith {};
// Players in the owning group may use the UAV without notifying the owner.
private _ownerGroup = _uav getVariable ["D207_UAVOwnerGroup",grpNull];
if (!isNull _ownerGroup && {group _controller isEqualTo _ownerGroup}) exitWith {};
// Prevent rapid repeated messages from the same player.
private _lastPingUID = _uav getVariable ["D207_UAVLastPingUID",""];
private _lastPingTime = _uav getVariable ["D207_UAVLastPingTime",-100];
if (_lastPingUID isEqualTo _controllerUID && {serverTime - _lastPingTime < 10}) exitWith {};
_uav setVariable ["D207_UAVLastPingUID",_controllerUID];
_uav setVariable ["D207_UAVLastPingTime",serverTime];
/*
	Find the current player object belonging to the stored UID.
	This continues to work after the UAV owner has respawned,
	because their new player object has the same UID.
*/
private _ownerPlayerIndex = allPlayers findIf {getPlayerUID _x isEqualTo _ownerUID};
// The owner may currently be disconnected.
if (_ownerPlayerIndex < 0) exitWith {
	[format[
	"%1 is owned by %2, but they are currently offline. You may claim the UAV if it has been handed to your group.",
	groupId group _uav,_uav getVariable ["D207_UAVOwnerName","another player"]]
	] remoteExecCall ["D207_fnc_UAVHint",owner _controller];
};
private _ownerPlayer = allPlayers select _ownerPlayerIndex;
private _connectingGroupName = groupId group _controller;
if (_connectingGroupName isEqualTo "") then {_connectingGroupName = "No Group";};
// Notify the UAV owner only.
[format["%1 from %2 has connected to your UAV:\n\n%3\n\nIf you have handed it over, they can claim ownership.",name _controller,_connectingGroupName,groupId group _uav]] remoteExecCall ["D207_fnc_UAVHint",owner _ownerPlayer];
// Also tell the connecting player that the owner was notified.
[format["%1 is currently owned by %2.\n\nThe owner has been notified.",groupId group _uav,_uav getVariable ["D207_UAVOwnerName","another player"]]] remoteExecCall ["D207_fnc_UAVHint",owner _controller];