params [["_box", objNull, [objNull]]];
if (!hasInterface || {isNull _box}) exitWith {};
[_box] execVM "207Scripts\LogisticalResupplyScript.sqf";
