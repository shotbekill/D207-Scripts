params [["_mainbox", objNull, [objNull]]];
if (!hasInterface || {isNull _mainbox}) exitWith {};
if (_mainbox getVariable ["D207_StaticsActionsAdded", false]) exitWith {};
_mainbox setVariable ["D207_StaticsActionsAdded", true, false];

[_mainbox, 0] call ace_cargo_fnc_setSpace;
_mainbox addAction ["Unpack Mk6 Mortar", {[_this select 3] spawn D207_fnc_StaticsMortar;}, _mainbox, 1.5, false, true, "", "true", 5, false, "", ""];
_mainbox addAction ["Unpack M2HB-QCB High", {[_this select 3] spawn D207_fnc_StaticsM2;}, _mainbox, 1.5, false, true, "", "true", 5, false, "", ""];
_mainbox addAction ["Unpack M41A4 TOW", {[_this select 3] spawn D207_fnc_StaticsTOW;}, _mainbox, 1.5, false, true, "", "true", 5, false, "", ""];
_mainbox addAction ["Unpack Spike AA", {[_this select 3] spawn D207_fnc_StaticsAA;}, _mainbox, 1.5, false, true, "", "true", 5, false, "", ""];
