params ["_params"];
_entity = _params select 0;
_D207UAVCHECKTFget = _params select 1;
_D207UAVCHECKTF = missionNamespace getVariable _D207UAVCHECKTFget;
if (unitIsUAV _entity) then {
	waitUntil {
	sleep 1;
	_CHECKTF = missionNamespace getVariable _D207UAVCHECKTFget;
	if ((isUAVConnected _entity) or _CHECKTF) exitWith {true};
	false;
	};
	if (missionNamespace getVariable _D207UAVCHECKTFget) exitWith {true};
	_ConnectedUAV = getConnectedUAV player;
	if !(_ConnectedUAV == _entity) exitWith {};
	_control = uavControl _entity;
	_Controller = _control select 0;
	_groupname = groupId group _Controller;
	_GroupUAVNumber = 0;
	waitUntil {
	sleep 0.1;
	_GroupUAVNumber = _GroupUAVNumber + 1;
	_NameGroupCheck = format ["%1 UAV %2", _groupname, _GroupUAVNumber];
	private _nameTaken = true;
	{
		if (groupId _x == _NameGroupCheck) exitWith {
			_nameTaken = false;
		};
	} forEach allGroups;
	NameGroup = _NameGroupCheck;
	_nameTaken;
	};
	_NameGroup = NameGroup;
	_vehicleGrp = group _entity;
	[_vehicleGrp, [_NameGroup]] remoteExec ["setGroupId", 0];
	missionNamespace setVariable [_D207UAVCHECKTFget, true, true];
};