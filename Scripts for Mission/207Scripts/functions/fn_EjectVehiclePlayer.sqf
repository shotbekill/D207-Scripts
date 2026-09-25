params [
    ["_unit", objNull, [objNull]],
    ["_safePos", [0, 0, 0], [[]]]
];

if (!hasInterface || {isNull _unit} || {player isNotEqualTo _unit}) exitWith {};
unassignVehicle _unit;
moveOut _unit;
_unit setPosATL _safePos;
