_Pname = name player;
private _playrping = parseText format ["<t size='1.25' color='#ff0000'>A ping has been sent, Please wait near a pad for a Hawkeye pilot"];
hint _playrping;
_Pos = mapGridPosition getPos player;
private _callteext = parseText format ["<t size='1.25' color='#ff0000'>%1 is waiting for reinsertion At Grid %2", _Pname, _Pos]; 
_Pingteam = ["BZ1","BZ2","B1PHQ","B5PHQ","B5PHQ2","BHEC","BHE2","BHES","RZ1","RZ2","R1PHQ","R5PHQ","R5PHQ2","RHEC","RHE2","RHES","GZ1","GZ2","G1PHQ","G5PHQ","G5PHQ2","GHEC","GHE2","GHES"]; 
_callteext remoteExec ["hint", _Pingteam];