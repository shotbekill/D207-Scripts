if (!hasInterface) exitWith {};
private _playerName = name player;
private _positionGrid = mapGridPosition (getPos player);
hint parseText "<t size='1.25' color='#ff0000'>A ping has been sent. Please wait near a pad for a Hawkeye pilot.</t>";

private _unitNames = ["BZ1","BZ2","B1PHQ","B5PHQ","B5PHQ2","BHEC","BHE2","BHES","RZ1","RZ2","R1PHQ","R5PHQ","R5PHQ2","RHEC","RHE2","RHES","GZ1","GZ2","G1PHQ","G5PHQ","G5PHQ2","GHEC","GHE2","GHES"];
private _targets = _unitNames apply {missionNamespace getVariable [_x, objNull]};
_targets = _targets select {!isNull _x && {isPlayer _x}};
private _message = format ["<t size='1.25' color='#ff0000'>%1 is waiting for reinsertion at Grid %2</t>", _playerName, _positionGrid];
[_message] remoteExecCall ["D207_fnc_ClientHint", _targets];
