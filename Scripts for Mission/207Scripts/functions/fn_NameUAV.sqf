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

// Stop here if no controller was passed
if (isNull _controller) exitWith {};

// Anti-spam: if this same player already renamed this UAV, do nothing
private _lastController = _uav getVariable ["D207_LastUAVController", objNull];
if (_lastController == _controller) exitWith {};

_uav setVariable ["D207_LastUAVController", _controller, true];

// Get controller group name
private _controllerGroup = group _controller;
private _controllerGroupName = groupId _controllerGroup;

if (_controllerGroupName == "") then {
	_controllerGroupName = name _controller;
};

// Get UAV group and mark it for cleanup when empty
private _uavGroup = group _uav;
if (isNull _uavGroup) exitWith {};

// Main group cleanup setting
_uavGroup deleteGroupWhenEmpty true;

// Find unused UAV group name
private _groupNumber = 1;
private _newGroupName = "";

while { _newGroupName == "" } do {
	private _nameToCheck = format ["%1 UAV %2", _controllerGroupName, _groupNumber];

	private _nameTaken = false;

	{
		if (_x != _uavGroup && { groupId _x == _nameToCheck }) exitWith {
			_nameTaken = true;
		};
	} forEach allGroups;

	if (!_nameTaken) then {
		_newGroupName = _nameToCheck;
	} else {
		_groupNumber = _groupNumber + 1;
	};
};
// Rename UAV group globally
_uavGroup setGroupIdGlobal [_newGroupName];