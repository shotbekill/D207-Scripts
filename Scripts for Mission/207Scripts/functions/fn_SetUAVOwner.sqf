params [
	["_uav", objNull, [objNull]],
	["_newOwner", objNull, [objNull]]
];

if (!isServer) exitWith {};
if (isNull _uav) exitWith {};
if (isNull _newOwner) exitWith {};
if !(unitIsUAV _uav) exitWith {};
private _ownerUID = getPlayerUID _newOwner;
if (_ownerUID isEqualTo "") exitWith {};
private _ownerGroup = group _newOwner;
private _ownerGroupName = groupId _ownerGroup;
if (_ownerGroupName isEqualTo "") then {_ownerGroupName = name _newOwner;};
// Store the ownership information globally.
_uav setVariable ["D207_UAVOwnerUID",_ownerUID,true];
_uav setVariable ["D207_UAVOwnerName",name _newOwner,true];
_uav setVariable ["D207_UAVOwnerGroup",_ownerGroup,true];
_uav setVariable ["D207_UAVOwnerGroupName",_ownerGroupName,true];
// Get the UAV group.
private _uavGroup = group _uav;
if (isNull _uavGroup) exitWith {};
_uavGroup deleteGroupWhenEmpty true;
// Find the first unused UAV group number.
private _groupNumber = 1;
private _newGroupName = "";
while { _newGroupName isEqualTo "" } do {
	private _nameToCheck = format ["%1 UAV %2",_ownerGroupName,_groupNumber];
	private _nameTaken = false;
	{
		if (_x != _uavGroup &&{ groupId _x isEqualTo _nameToCheck }) exitWith {_nameTaken = true;};
	} forEach allGroups;
	if (_nameTaken) then {_groupNumber = _groupNumber + 1;} else {_newGroupName = _nameToCheck;};
};
// Rename globally.
_uavGroup setGroupIdGlobal [_newGroupName];
_uav setVariable ["D207_UAVCurrentName",_newGroupName,true];