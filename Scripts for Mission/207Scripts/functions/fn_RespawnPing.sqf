if (!hasInterface) exitWith {};
private _groupName = groupId (group player);
private _unitNames = ["BZ1","BZ2","B1PHQ","B5PHQ","B5PHQ2","BHEC","BHE2","BHES","RZ1","RZ2","R1PHQ","R5PHQ","R5PHQ2","RHEC","RHE2","RHES","GZ1","GZ2","G1PHQ","G5PHQ","G5PHQ2","GHEC","GHE2","GHES"];
private _targets = _unitNames apply {missionNamespace getVariable [_x, objNull]};
_targets = _targets select {!isNull _x && {isPlayer _x}};
private _message = format ["<t size='1.25' color='#ff0000'>Someone from %1 has respawned</t>", _groupName];
[_message] remoteExecCall ["D207_fnc_ClientHint", _targets];

private _teleportFOB = if (!isNil {missionNamespace getVariable "FOBTELE"} && {!isNull (missionNamespace getVariable ["FOBTELE", objNull])}) then {"Online"} else {"Offline"};
private _teleportRelocator = if (missionNamespace getVariable ["SpawnRelocator", false] && {!isNil {missionNamespace getVariable "Relocator"}} && {!isNull (missionNamespace getVariable ["Relocator", objNull])}) then {"Online"} else {"Offline"};
private _text1 = parseText format ["<t size='1.25' color='#ff0000'>Teleport to FOB is %1</t>", _teleportFOB];
private _text2 = parseText format ["<t size='1.25' color='#ff0000'>Teleport to Relocator is %1</t>", _teleportRelocator];
private _text3 = parseText "<t size='1.25' color='#ff0000'>Teleports are usable from the laptop.</t>";
hint composeText [_text1, lineBreak, _text2, lineBreak, _text3];
