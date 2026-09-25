params [["_caller", objNull, [objNull]]];

if (!isServer) exitWith {[player] remoteExec ["D207_fnc_Outro", 2];};
if (isRemoteExecuted && {isNull _caller || {!isPlayer _caller}}) exitWith {};
if (isRemoteExecuted && {remoteExecutedOwner != owner _caller}) exitWith {};
if (isRemoteExecuted && {isNull (getAssignedCuratorLogic _caller)}) exitWith {};
if !(missionNamespace getVariable ["EndEx", false]) exitWith {};
if !(missionNamespace getVariable ["EndOp", false]) exitWith {};

missionNamespace setVariable ["EndOp", false, true];
[] remoteExec ["D207_fnc_PlayOutro", -2];
uiSleep 0.1;
[] call D207_fnc_EndOp;
