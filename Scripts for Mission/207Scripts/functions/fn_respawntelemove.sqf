params [["_vehicle", objNull, [objNull]]];

if (isNull _vehicle) exitWith {
    systemChat "Spawn Relocator failed: no target object found.";
};

if (missionNamespace getVariable ["SpawnRelocator", false]) exitWith {
    systemChat "There Is A Relocator Setup, Pack Other Relocator To Setup A New One";
};

systemChat "Setting up Spawn Relocator, This will take some time";

_vehicle allowDamage false;
_vehicle enableSimulation false;

missionNamespace setVariable ["SpawnRelocator", true, true];


// ================================================================
// Snap object to ground/surface
// ================================================================
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


// ================================================================
// Spawn object on ground, then snap it correctly
// ================================================================
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


sleep 3;


// ================================================================
// Spawn Relocator Objects
// ================================================================

[_vehicle, "Land_HBarrier_5_F", [-0.75, 6.25, 0], 0] call _fnc_spawnGroundObject;
sleep 6;

[_vehicle, "Land_HBarrier_5_F", [2.75, 4.25, 0], 90] call _fnc_spawnGroundObject;
sleep 6;

[_vehicle, "Land_HBarrier_5_F", [2.75, -1.5, 0], 90] call _fnc_spawnGroundObject;
sleep 6;

[_vehicle, "Land_HBarrier_5_F", [2.75, -7.25, 0], 90] call _fnc_spawnGroundObject;
sleep 6;

[_vehicle, "Land_HBarrier_5_F", [2.75, -13, 0], 90] call _fnc_spawnGroundObject;
sleep 6;

[_vehicle, "Land_HBarrier_3_F", [1.75, -16.5, 0], 0] call _fnc_spawnGroundObject;
sleep 6;

[_vehicle, "Land_SandbagBarricade_01_F", [-4.5, -16.75, 0], 180] call _fnc_spawnGroundObject;
sleep 6;

[_vehicle, "Land_HBarrier_3_F", [-11, -16.5, 0], 0] call _fnc_spawnGroundObject;
sleep 6;

[_vehicle, "Land_HBarrier_5_F", [-12, -13, 0], 90] call _fnc_spawnGroundObject;
sleep 6;

[_vehicle, "Land_HBarrier_5_F", [-12, -7.25, 0], 90] call _fnc_spawnGroundObject;
sleep 6;

[_vehicle, "Land_HBarrier_5_F", [-12, -1.5, 0], 90] call _fnc_spawnGroundObject;
sleep 6;

[_vehicle, "Land_HBarrier_5_F", [-12, 4.25, 0], 90] call _fnc_spawnGroundObject;
sleep 6;

[_vehicle, "Land_HBarrier_5_F", [-8.5, 6.25, 0], 0] call _fnc_spawnGroundObject;
sleep 6;

[_vehicle, "Land_MedicalTent_01_MTP_closed_F", [-4.5, -11.75, 0], 0] call _fnc_spawnGroundObject;
sleep 6;


// ================================================================
// Table and laptop
// ================================================================

private _CampingTableOB = [_vehicle, "Land_CampingTable_small_F", [-3, 4.75, 0], 180] call _fnc_spawnGroundObject;
sleep 5;

/*
    Do NOT snap this one to ground.
    It is being spawned on TOP of the table.
*/
private _Laptop = [
    [_CampingTableOB, "TOP"],
    "Land_Laptop_device_F",
    1,
    [0, 0, 0],
    45,
    {0},
    false
] call BIS_fnc_spawnObjects;

private _LaptopOB = _Laptop select 0;


// ================================================================
// ACE Actions
// ================================================================

private _RelocatorLapTop = [
    "RelocatorLapTop",
    "<t color='#207207'>Relocator LapTop</t>",
    "",
    {nil},
    {true},
    {},
    [],
    [0, 0, 0],
    7
] call ace_interact_menu_fnc_createAction;

[_LaptopOB, 0, [], _RelocatorLapTop] call ace_interact_menu_fnc_addActionToObject;


private _Ping = [
    "Ping",
    "<t color='#00FFEA'>Ping For Reinsertion</t>",
    "",
    {[] spawn D207_fnc_Reinsertionping;},
    {true}
] call ace_interact_menu_fnc_createAction;

[_LaptopOB, 0, ["RelocatorLapTop"], _Ping] call ace_interact_menu_fnc_addActionToObject;


private _Heal = [
    "HealBase",
    "<t color='#00FF00'>Heal</t>",
    "",
    {player setDamage 0;},
    {true}
] call ace_interact_menu_fnc_createAction;

[_LaptopOB, 0, ["RelocatorLapTop"], _Heal] call ace_interact_menu_fnc_addActionToObject;


sleep 5;


// ================================================================
// Helipad and hidden selector
// ================================================================

[_vehicle, "Land_HelipadRescue_F", [-4.5, 15.5, 0], 0] call _fnc_spawnGroundObject;
sleep 3;

private _3DSelector = [_vehicle, "VR_3DSelector_01_exit_F", [-4.5, -4.75, 0], 0] call _fnc_spawnGroundObject;
sleep 1;
[_3DSelector, true] remoteExec ["hideObjectGlobal", 2];

missionNamespace setVariable ["Relocator", _3DSelector, true];

systemChat "Spawn Relocator has been setup";