params [
    ["_boxPos", [], [[]]],
    ["_caller", objNull, [objNull]]
];
if (_boxPos isEqualTo []) exitWith {};

private _notify = {
    params ["_text"];
    if (!isNull _caller) then {
        [_text] remoteExecCall ["D207_fnc_ClientHint", owner _caller];
    };
};
["Making full resupply + vehicle..."] call _notify;

private _flatbed = "rhsusf_M1084A1R_SOV_M2_D_fmtv_socom" createVehicle _boxPos;

private _tracks = "BL_Case_D207_Tracks" createVehicle _boxPos;
[_flatbed, _tracks] call boxloader_fnc_load;
private _wheels = "BL_Case_D207_Wheels" createVehicle _boxPos;
[_flatbed, _wheels] call boxloader_fnc_load;

private _baseBoxSpawn = [[_flatbed, "TOP"], "BL_Crate_D207_OpDem", 1, [0,5,0], 0, {0}, false] call BIS_fnc_spawnObjects;
private _baseBox = _baseBoxSpawn param [0, objNull];
if (!isNull _baseBox) then {
    [_baseBox, 20] call ace_cargo_fnc_setSpace;
    private _resupply1 = [_baseBox] spawn D207_fnc_OpAlpha;
    private _resupply2 = [_baseBox] spawn D207_fnc_OpBravo;
    private _resupply3 = [_baseBox] spawn D207_fnc_OpCharlie;
    private _resupply4 = [_baseBox] spawn D207_fnc_OpReaper;
    private _resupply5 = [_baseBox] spawn D207_fnc_OpPHQ;
    waitUntil {
        scriptDone _resupply1 &&
        {scriptDone _resupply2} &&
        {scriptDone _resupply3} &&
        {scriptDone _resupply4} &&
        {scriptDone _resupply5}
    };
    _baseBox allowDamage false;
    _baseBox enableSimulation true;
    [_flatbed, _baseBox] call boxloader_fnc_load;
};

private _ammoBox = "Boxloader_SmallPallet_Ammo" createVehicle _boxPos;
[_ammoBox, 5000] remoteExec ["ace_rearm_fnc_makeSource", 2];
[_ammoBox, 5000] remoteExec ["ace_rearm_fnc_setSupplyCount", 2];
_ammoBox setVariable ["ace_isRepairFacility", 1, true];
[_flatbed, _ammoBox] call boxloader_fnc_load;

for "_i" from 1 to 3 do {
    private _fuelTank = "FlexibleTank_01_forest_F" createVehicle _boxPos;
    [_flatbed, _fuelTank] call boxloader_fnc_load;
};

for "_i" from 1 to 2 do {
    private _palletJack = "boxloader_pallet_jack" createVehicle _boxPos;
    [_flatbed, _palletJack] call boxloader_fnc_load;
};

uiSleep 1;
["Full resupply is done."] call _notify;
