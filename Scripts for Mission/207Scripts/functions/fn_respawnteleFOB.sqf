params [["_vehicle", objNull, [objNull]]];
if (isNull _vehicle) exitWith {
    systemChat "Spawn Relocator failed: no target object found.";
};
systemChat "Setting up FOB Spawn";
_vehicle allowDamage false;
_vehicle enableSimulation false;
_vehicle setVariable ["FOBSpawn", true, true];
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

    private _hits = lineIntersectsSurfaces [
        [_xPos, _yPos, 1000],
        [_xPos, _yPos, -1000],
        _obj,
        objNull,
        true,
        1,
        "GEOM",
        "NONE"
    ];

    private _surfaceASL = [_xPos, _yPos, getTerrainHeightASL [_xPos, _yPos]];
    private _surfaceNormal = surfaceNormal [_xPos, _yPos];

    if (_hits isNotEqualTo []) then {
        _surfaceASL = (_hits select 0) select 0;
        _surfaceNormal = (_hits select 0) select 1;
    };

    _obj setPosASL [
        _xPos,
        _yPos,
        (_surfaceASL select 2) + _zOffset
    ];

    if (_alignToSlope) then {
        _obj setVectorUp _surfaceNormal;
    };
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

    private _spawned = [
        [_anchor, "GROUND"],
        _className,
        1,
        _offset,
        _dirOffset,
        {0},
        false
    ] call BIS_fnc_spawnObjects;

    private _obj = _spawned select 0;

    [_obj, _alignToSlope, _zOffset] call _fnc_snapObjectToSurface;

    _obj
};
sleep 1;
[_vehicle, "Land_BagFence_Long_F", [8,-3.5,0], 270] call _fnc_spawnGroundObject;
[_vehicle, "Land_BagFence_Long_F", [8,-6.5,0], 270] call _fnc_spawnGroundObject;
[_vehicle, "Land_BagFence_Long_F", [6.5,-8,0], 0] call _fnc_spawnGroundObject;
[_vehicle, "Land_BagFence_Long_F", [3.5,-8,0], 180] call _fnc_spawnGroundObject;
[_vehicle, "Land_BagFence_Long_F", [2,-6.5,0], 270] call _fnc_spawnGroundObject;
[_vehicle, "Land_BagFence_Long_F", [2,-3.5,0], 270] call _fnc_spawnGroundObject;
private _CampingTableOB = [_vehicle, "Land_CampingTable_small_F", [1.75,-1.5,0], 90] call _fnc_spawnGroundObject;
private _Laptop = [
    [_CampingTableOB, "TOP"],
    "Land_Laptop_device_F",
    1,
    [0, 0, 0],
    0,
    {0},
    false
] call BIS_fnc_spawnObjects;
private _LaptopOB = _Laptop select 0;
private _RelocatorLapTop = [
    "RelocatorLapTop",
    "<t color='#207207'>FOB LapTop</t>",
    "",
    {nil},
    {true},
    {},
    [],
    [0, 0, 0],
    7
] call ace_interact_menu_fnc_createAction;
[_LaptopOB, 0, [], _RelocatorLapTop] remoteExec ["ace_interact_menu_fnc_addActionToObject", 0, true];
private _Ping = [
    "Ping",
    "<t color='#00FFEA'>Ping For Reinsertion</t>",
    "",
    {[] spawn D207_fnc_Reinsertionping;},
    {true}
] call ace_interact_menu_fnc_createAction;
[_LaptopOB, 0, ["RelocatorLapTop"], _Ping] remoteExec ["ace_interact_menu_fnc_addActionToObject", 0, true];
private _Heal = [
    "HealBase",
    "<t color='#00FF00'>Heal</t>",
    "",
    {[objNull, player] call ace_medical_treatment_fnc_fullHeal;},
    {true}
] call ace_interact_menu_fnc_createAction;
[_LaptopOB, 0, ["RelocatorLapTop"], _Heal] remoteExec ["ace_interact_menu_fnc_addActionToObject", 0, true];
systemChat "Finishing Setup Of Relocator.";
private _3DSelector = [_vehicle, "VR_3DSelector_01_exit_F", [5,-5,0], 90] call _fnc_spawnGroundObject;
[_3DSelector, true] remoteExec ["hideObjectGlobal", 2];
missionNamespace setVariable ["FOBTELE", _3DSelector, true];
systemChat "FOB Spawn has been setup";