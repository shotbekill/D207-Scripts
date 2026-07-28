/*
	Add classnames inside the arrays, separated by commas.

	Example:
	private _guns = ["SMA_AUG_A3_F","SMA_AUG_EGLM"];
*/

// Arsenal additions
private _guns = [];
private _unf = [];
private _vests = [];
private _backpacks = [];
private _hats = [];
private _misc = [];

// Vehicle spawner additions
private _vehicleListPlatoon = [];
private _vehicleListFoxtrot = [];
private _vehicleListHawkeye = [];
private _vehicleListDrone = [];

// !!! DO NOT EDIT PAST HERE !!!

// Find magazines and attachments for newly added weapons.
private _magazinesToAdd = [];
private _attachmentsToAdd = [];
{
	{_magazinesToAdd pushBackUnique _x;} forEach compatibleMagazines _x;
	{_attachmentsToAdd pushBackUnique _x;} forEach compatibleItems _x;
} forEach _guns;

// Add arsenal entries to the existing global arrays.
{D207_guns pushBackUnique _x;} forEach _guns;
{D207_unf pushBackUnique _x;} forEach _unf;
{D207_Vests pushBackUnique _x;} forEach _vests;
{D207_Backpacks pushBackUnique _x;} forEach _backpacks;
{D207_Hats pushBackUnique _x;} forEach _hats;
{D207_misc pushBackUnique _x;} forEach _misc;

// Add the magazines and attachments generated from the newly added weapons.
{D207_Ammo pushBackUnique _x;} forEach _magazinesToAdd;
{D207_Atmet pushBackUnique _x;} forEach _attachmentsToAdd;

// Add vehicle entries to their correct lists.
{D207_VehicleListPlatoon pushBackUnique _x;} forEach _vehicleListPlatoon;
{D207_VehicleListFoxtrot pushBackUnique _x;} forEach _vehicleListFoxtrot;
{D207_VehicleListHawkeye pushBackUnique _x;} forEach _vehicleListHawkeye;
{D207_VehicleListDrone pushBackUnique _x;} forEach _vehicleListDrone;