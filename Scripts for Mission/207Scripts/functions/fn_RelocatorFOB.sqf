params [
    ["_vehicle", objNull, [objNull]],
    ["_caller", objNull, [objNull]]
];

if (!isServer || {isNull _vehicle} || {isNull _caller} || {!isPlayer _caller}) exitWith {};
if (isRemoteExecuted && {remoteExecutedOwner != owner _caller}) exitWith {};
if (_caller distance _vehicle > 10) exitWith {};
if (_vehicle getVariable ["FOBSpawn", false]) exitWith {};

_vehicle setVariable ["FOBSpawn", true, true];
_vehicle allowDamage false;
_vehicle enableSimulationGlobal false;
["<t color='#207207'>Setting up FOB Spawn.</t>"] remoteExecCall ["D207_fnc_ClientHint", owner _caller];

private _createdObjects = [];
private _fnc_snapObjectToSurface = {
    params [
        ["_obj", objNull, [objNull]],
        ["_alignToSlope", false, [false]],
        ["_zOffset", 0, [0]]
    ];
    if (isNull _obj) exitWith {};
    private _posASL = getPosASL _obj;
    private _xPos = _posASL select 0;
    private _yPos = _posASL select 1;
    private _hits = lineIntersectsSurfaces [[_xPos,_yPos,1000], [_xPos,_yPos,-1000], _obj, objNull, true, 1, "GEOM", "NONE"];
    private _surfaceASL = [_xPos, _yPos, getTerrainHeightASL [_xPos,_yPos]];
    private _surfaceNormal = surfaceNormal [_xPos,_yPos];
    if (_hits isNotEqualTo []) then {
        _surfaceASL = (_hits select 0) select 0;
        _surfaceNormal = (_hits select 0) select 1;
    };
    _obj setPosASL [_xPos, _yPos, (_surfaceASL select 2) + _zOffset];
    if (_alignToSlope) then {_obj setVectorUp _surfaceNormal;};
};
private _fnc_spawnGroundObject = {
    params [
        ["_anchor", objNull, [objNull]],
        ["_className", "", [""]],
        ["_offset", [0,0,0], [[]]],
        ["_dirOffset", 0, [0]],
        ["_alignToSlope", false, [false]],
        ["_zOffset", 0, [0]]
    ];
    private _spawned = [[_anchor,"GROUND"], _className, 1, _offset, _dirOffset, {0}, false] call BIS_fnc_spawnObjects;
    private _obj = _spawned param [0, objNull];
    if (!isNull _obj) then {
        [_obj, _alignToSlope, _zOffset] call _fnc_snapObjectToSurface;
        _createdObjects pushBack _obj;
    };
    _obj
};

uiSleep 1;
{
    _x params ["_offset", "_dir"];
    [_vehicle, "Land_BagFence_Long_F", _offset, _dir] call _fnc_spawnGroundObject;
} forEach [
    [[8,-3.5,0],270],
    [[8,-6.5,0],270],
    [[6.5,-8,0],0],
    [[3.5,-8,0],180],
    [[2,-6.5,0],270],
    [[2,-3.5,0],270]
];

private _table = [_vehicle, "Land_CampingTable_small_F", [1.75,-1.5,0], 90] call _fnc_spawnGroundObject;
private _laptopSpawn = [[_table,"TOP"], "Land_Laptop_device_F", 1, [0,0,0], 0, {0}, false] call BIS_fnc_spawnObjects;
private _laptop = _laptopSpawn param [0, objNull];
if (!isNull _laptop) then {
    _createdObjects pushBack _laptop;
    ["CREATE", _laptop] remoteExec ["D207_fnc_RelocatorLaptop", -2, _laptop];
};

private _selector = [_vehicle, "VR_3DSelector_01_exit_F", [5,-5,0], 90] call _fnc_spawnGroundObject;
if (!isNull _selector) then {
    _selector hideObjectGlobal true;
    missionNamespace setVariable ["FOBTELE", _selector, true];
};
_vehicle setVariable ["D207_FOBObjects", _createdObjects, true];
["<t color='#207207'>FOB Spawn has been set up.</t>"] remoteExecCall ["D207_fnc_ClientHint", owner _caller];
