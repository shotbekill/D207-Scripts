private _Group = group player;
private _GroupName = groupId _Group;
private _calltext = parseText format ["<t size='1.25' color='#ff0000'>Someone from %1 has respawned", _GroupName]; 
_Pingteam = ["BZ1","BZ2","B1PHQ","B5PHQ","B5PHQ2","BHEC","BHE2","BHES","RZ1","RZ2","R1PHQ","R5PHQ","R5PHQ2","RHEC","RHE2","RHES","GZ1","GZ2","G1PHQ","G5PHQ","G5PHQ2","GHEC","GHE2","GHES"]; 
_calltext remoteExec ["hint", _Pingteam];

_TeleportFOB = "Offline";
_TeleportRelocator = "Offline";
if (missionNamespace getVariable "SpawnRelocator" && !isNil "Relocator") then {_TeleportRelocator = "Online"};
if (!isNil "FOBTELE") then {_TeleportFOB = "Online"};

private _text1 = parseText format ["<t size='1.25' color='#ff0000'>Teleport to FOB is %1", _TeleportFOB];
private _text2 = parseText format ["<t size='1.25' color='#ff0000'>Teleport to Relocator is %1", _TeleportRelocator];
private _text3 = parseText format ["<t size='1.25' color='#ff0000'>Teleport's are usble from the Laptop"];
hint composeText [_text1, lineBreak, _text2, lineBreak, _text3];
