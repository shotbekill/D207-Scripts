params [
	["_uav", objNull, [objNull]],
	["_claimant", objNull, [objNull]]
];
if (!isServer) exitWith {};
if (isNull _uav) exitWith {};
if (isNull _claimant) exitWith {};
if !(unitIsUAV _uav) exitWith {};
/*
	Security check.
	The client requesting the claim must own the supplied
	player object. This prevents clients from claiming a UAV
	on behalf of another player.
*/
if (isRemoteExecuted && { remoteExecutedOwner != owner _claimant }) exitWith {};
private _claimantUID = getPlayerUID _claimant;
if (_claimantUID isEqualTo "") exitWith {};
// Store the previous owner information before transferring it.
private _oldOwnerUID = _uav getVariable ["D207_UAVOwnerUID",""];
private _oldOwnerName = _uav getVariable ["D207_UAVOwnerName","Unknown player"];
private _oldUAVName = groupId group _uav;
// The player already owns this UAV.
if (_oldOwnerUID isEqualTo _claimantUID) exitWith {
	[format["You already own %1.",_oldUAVName]] remoteExecCall ["D207_fnc_UAVHint",owner _claimant];
};
/*
	Anyone may claim the UAV.
	This deliberately does not check whether the old owner
	is online, connected or currently controlling the UAV.
*/
[_uav,_claimant] call D207_fnc_SetUAVOwner;
private _newUAVName = groupId group _uav;
// Clear the old connection-ping information so future connection notifications work normally.
_uav setVariable ["D207_UAVLastPingUID","",true];
_uav setVariable ["D207_UAVLastPingTime",-100,true];
// Confirm the claim to the new owner.
[format["You have claimed ownership of:\n\n%1",_newUAVName]] remoteExecCall ["D207_fnc_UAVHint",owner _claimant];
// Notify the previous owner if they are still online.
if (_oldOwnerUID isNotEqualTo "") then {
	private _oldOwnerIndex = allPlayers findIf {getPlayerUID _x isEqualTo _oldOwnerUID};
	if (_oldOwnerIndex >= 0) then {
		private _oldOwnerPlayer = allPlayers select _oldOwnerIndex;
		[format["%1 from %2 has claimed your UAV.\n\nOld name: %3\nNew name: %4",name _claimant,groupId group _claimant,_oldUAVName,_newUAVName]] remoteExecCall ["D207_fnc_UAVHint",owner _oldOwnerPlayer];
	};
};