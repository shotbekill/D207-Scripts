/*
    D207_fnc_openVehicleEditor

    Opens the Zeus Enhanced vehicle garage for a normal player.

    This is intended to be called immediately after the vehicle is spawned.
    It can only be used once per vehicle.

    Parameters:
        0: Vehicle <OBJECT>
*/

params [
    ["_vehicle", objNull, [objNull]]
];

if (!hasInterface) exitWith {};

if (isNull _vehicle) exitWith {
    hint "The vehicle no longer exists.";
};

if (!alive _vehicle) exitWith {
    hint "Destroyed vehicles cannot be edited.";
};

if !(
    _vehicle isKindOf "LandVehicle"
    || {_vehicle isKindOf "Air"}
    || {_vehicle isKindOf "Ship"}
) exitWith {
    hint "This object cannot be edited.";
};


// -------------------------------------------------------------------------
// Confirm this player spawned the vehicle
// -------------------------------------------------------------------------

private _ownerUID = _vehicle getVariable [
    "D207_spawnOwnerUID",
    ""
];

if (_ownerUID isNotEqualTo getPlayerUID player) exitWith {
    hint "You did not spawn this vehicle.";
};


// -------------------------------------------------------------------------
// Prevent the editor being opened again
// -------------------------------------------------------------------------

if (_vehicle getVariable ["D207_vehicleEditorUsed", false]) exitWith {
    hint "The editing opportunity for this vehicle has expired.";
};

// Mark it as used before opening the editor.
_vehicle setVariable [
    "D207_vehicleEditorUsed",
    true,
    true
];


// -------------------------------------------------------------------------
// Check Zeus Enhanced
// -------------------------------------------------------------------------

if (
    isNil "zen_garage_fnc_populateLists"
    || {isNil "zen_garage_fnc_showVehicleInfo"}
    || {isNil "zen_garage_fnc_updateCamera"}
) exitWith {
    hint "Zeus Enhanced vehicle garage is not available.";
};

if (!isNull findDisplay 10500) exitWith {};


// -------------------------------------------------------------------------
// Open normal ZEN garage if the player happens to be Zeus
// -------------------------------------------------------------------------

if (!isNull findDisplay 312) exitWith {
    [_vehicle] call zen_garage_fnc_openGarage;
};


// -------------------------------------------------------------------------
// Open ZEN garage without Zeus
// -------------------------------------------------------------------------

private _parentDisplay = findDisplay 46;

if (isNull _parentDisplay) exitWith {
    hint "The vehicle editor could not be opened.";
};

zen_garage_center = _vehicle;

private _display = _parentDisplay createDisplay "zen_garage_display";

if (isNull _display) exitWith {
    zen_garage_center = nil;
    hint "The vehicle editor display could not be created.";
};

zen_garage_mouseButtons = [[], []];
zen_garage_interfaceShown = true;
zen_garage_visionMode = 0;

[] call zen_garage_fnc_showVehicleInfo;
[] call zen_garage_fnc_populateLists;

[zen_garage_currentTab, true] call zen_garage_fnc_onTabSelect;


// -------------------------------------------------------------------------
// Disable Apply To All
// -------------------------------------------------------------------------

private _applyButton = _display displayCtrl 341;

_applyButton ctrlEnable false;
_applyButton ctrlShow false;


// -------------------------------------------------------------------------
// Create garage camera
// -------------------------------------------------------------------------

zen_garage_camHelper = "Logic" createVehicleLocal [0, 0, 0];
zen_garage_camHelper attachTo [
    _vehicle,
    zen_garage_helperPos
];

zen_garage_camera = "camera" camCreate (
    ASLToAGL getPosASL _vehicle
);

zen_garage_camera cameraEffect [
    "internal",
    "back"
];

zen_garage_camera camPrepareFocus [-1, -1];
zen_garage_camera camPrepareFov 0.35;
zen_garage_camera camCommitPrepared 0;

showCinemaBorder false;

[nil, 0] call zen_garage_fnc_onMouseZChanged;

zen_garage_camDraw3D = addMissionEventHandler [
    "Draw3D",
    {
        call zen_garage_fnc_updateCamera;
    }
];