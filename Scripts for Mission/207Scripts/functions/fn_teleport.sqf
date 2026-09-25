params [["_type", 0, [0]]];
if (!hasInterface) exitWith {};
private _destination = switch (_type) do {
    case 1: {missionNamespace getVariable ["FOBTELE", objNull]};
    case 2: {missionNamespace getVariable ["Relocator", objNull]};
    default {objNull};
};
if (isNull _destination) exitWith {hint "Teleport destination is not available.";};
call BIS_fnc_VRFadeOut;
uiSleep 1;
player setPos (getPos _destination);
uiSleep 1;
call BIS_fnc_VRFadeIn;
