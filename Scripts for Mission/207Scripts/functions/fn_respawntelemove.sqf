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
systemChat "Unpacking HBarrier's.";
sleep 60;
systemChat "HBarrier 1/12.";
[_vehicle, "Land_HBarrier_5_F", [-0.75, 6.25, 0], 0] call _fnc_spawnGroundObject;
sleep 1;
systemChat "HBarrier 2/12.";
[_vehicle, "Land_HBarrier_5_F", [2.75, 4.25, 0], 90] call _fnc_spawnGroundObject;
sleep 1;
systemChat "HBarrier 3/12.";
[_vehicle, "Land_HBarrier_5_F", [2.75, -1.5, 0], 90] call _fnc_spawnGroundObject;
sleep 1;
systemChat "HBarrier 4/12.";
[_vehicle, "Land_HBarrier_5_F", [2.75, -7.25, 0], 90] call _fnc_spawnGroundObject;
sleep 1;
systemChat "HBarrier 5/12.";
[_vehicle, "Land_HBarrier_5_F", [2.75, -13, 0], 90] call _fnc_spawnGroundObject;
sleep 1;
systemChat "HBarrier 6/12.";
[_vehicle, "Land_HBarrier_3_F", [1.75, -16.5, 0], 0] call _fnc_spawnGroundObject;
sleep 1;
systemChat "HBarrier 7/12.";
[_vehicle, "Land_HBarrier_3_F", [-11, -16.5, 0], 0] call _fnc_spawnGroundObject;
sleep 1;
systemChat "HBarrier 8/12.";
[_vehicle, "Land_HBarrier_5_F", [-12, -13, 0], 90] call _fnc_spawnGroundObject;
sleep 1;
systemChat "HBarrier 9/12.";
[_vehicle, "Land_HBarrier_5_F", [-12, -7.25, 0], 90] call _fnc_spawnGroundObject;
sleep 1;
systemChat "HBarrier 10/12.";
[_vehicle, "Land_HBarrier_5_F", [-12, -1.5, 0], 90] call _fnc_spawnGroundObject;
sleep 1;
systemChat "HBarrier 11/12.";
[_vehicle, "Land_HBarrier_5_F", [-12, 4.25, 0], 90] call _fnc_spawnGroundObject;
sleep 1;
systemChat "HBarrier 12/12.";
[_vehicle, "Land_HBarrier_5_F", [-8.5, 6.25, 0], 0] call _fnc_spawnGroundObject;
sleep 6;
systemChat "Unpacking Sandbag.";
[_vehicle, "Land_SandbagBarricade_01_F", [-4.5, -16.75, 0], 180] call _fnc_spawnGroundObject;
sleep 6;
systemChat "Unpacking Medical Tent.";
[_vehicle, "Land_MedicalTent_01_MTP_closed_F", [-4.5, -11.75, 0], 0] call _fnc_spawnGroundObject;
sleep 6;
systemChat "Unpacking Table.";
private _CampingTableOB = [_vehicle, "Land_CampingTable_small_F", [-3, 4.75, 0], 180] call _fnc_spawnGroundObject;
sleep 6;
systemChat "Unpacking Laptop.";
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
systemChat "Unpacking Helipad 1/1.";
[_vehicle, "Land_HelipadRescue_F", [-4.5, 15.5, 0], 0] call _fnc_spawnGroundObject;
sleep 10;
systemChat "Finishing Setup Of Relocator.";
private _3DSelector = [_vehicle, "VR_3DSelector_01_exit_F", [-4.5, -4.75, 0], 0] call _fnc_spawnGroundObject;
sleep 15;
[_3DSelector, true] remoteExec ["hideObjectGlobal", 2];
missionNamespace setVariable ["Relocator", _3DSelector, true];
systemChat "Spawn Relocator has been setup";