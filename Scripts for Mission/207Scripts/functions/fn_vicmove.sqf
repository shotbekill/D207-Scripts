params [
	["_packerbox", objNull, [objNull]],
	["_caller", objNull, [objNull]],
	["_packingType", "LAND", [""]]
];

if (!isServer) exitWith {};
if (isNull _packerbox) exitWith {};
if (isNull _caller) exitWith {};
_packingType = toUpper _packingType;
if (isRemoteExecuted && {remoteExecutedOwner != owner _caller}) exitWith {};
private _sendMessage =
{
	params ["_message"];
	["MESSAGE",_message] remoteExec ["D207_fnc_unboxvic",owner _caller];
};
if (_caller distance _packerbox > 8) exitWith {["You are too far away from the vehicle packer."] call _sendMessage;};
if (_packerbox getVariable ["D207_packBusy",false]) exitWith {["This vehicle packer is already being used."] call _sendMessage;};
_packerbox setVariable ["D207_packBusy",true,true];
// Select search settings.
private _searchClass = if (_packingType isEqualTo "AIR") then {"Air"} else {"LandVehicle"};
private _searchDistance = if (_packingType isEqualTo "AIR") then {15} else {10};
private _vehicleDescription = if (_packingType isEqualTo "AIR") then {"airframe"} else {"land vehicle"};
// Find the closest valid vehicle.
private _nearestVehicles = nearestObjects [_packerbox,[_searchClass],_searchDistance,true];
_nearestVehicles = _nearestVehicles select {alive _x && {_x != _packerbox} && {typeOf _x != "boxloader_pallet_jack"} && {typeOf _x != "ACE_friesAnchorBar"} && {!(_x getVariable ["D207_isPacked",false])}};
private _victopack = _nearestVehicles param [0,objNull];
if (isNull _victopack) exitWith {_packerbox setVariable ["D207_packBusy",false,true];[format ["No %1 within %2 metres to pack.",_vehicleDescription,_searchDistance]] call _sendMessage;};
if (abs speed _victopack > 1) exitWith {_packerbox setVariable ["D207_packBusy",false,true];[format ["The %1 must be stationary.",_vehicleDescription]] call _sendMessage;};
if (crew _victopack isNotEqualTo []) exitWith {_packerbox setVariable ["D207_packBusy",false,true];["Everyone must exit the vehicle before it can be packed."] call _sendMessage;};
if (!isNull (attachedTo _victopack)) exitWith {_packerbox setVariable ["D207_packBusy",false,true];["Detach the vehicle before packing it."] call _sendMessage;};
if (!isNull (isVehicleCargo _victopack)) exitWith {_packerbox setVariable ["D207_packBusy",false,true];["Unload the vehicle from its carrier before packing it."] call _sendMessage;};
// Save the vehicle's original location before doing anything to it.
private _originalPosition = getPosATL _victopack;
private _originalDirection = getDir _victopack;
private _originalVectorDir = vectorDir _victopack;
private _originalVectorUp = vectorUp _victopack;
private _className = typeOf _victopack;
private _displayName = getText (configFile >> "CfgVehicles" >> _className >> "displayName");
if (_displayName isEqualTo "") then {_displayName = _className;};
/*
	Find all possible Vehicle-in-Vehicle cargo carriers.
	This includes:
	- The vehicle itself.
	- BoxLoader retrofit helper objects attached to it.
	- Any helpers attached beneath another helper.
*/
private _cargoCarriers = [_victopack];
private _attachedQueue = attachedObjects _victopack;
while {_attachedQueue isNotEqualTo []} do {
	private _attachedObject = _attachedQueue deleteAt 0;
	if !(_attachedObject in _cargoCarriers) then
	{
		_cargoCarriers pushBack _attachedObject;
		_attachedQueue append (attachedObjects _attachedObject);
	};
};
// The packing operation uses locality-sensitive commands. Empty vehicles and
// BoxLoader helper objects can safely be transferred back to the server first.
{
	if (!local _x) then {_x setOwner 2;};
} forEach _cargoCarriers;
private _localityTimeout = diag_tickTime + 2;
waitUntil {
	sleep 0.05;
	({_x isNotEqualTo objNull && {!local _x}} count _cargoCarriers) isEqualTo 0 || {diag_tickTime >= _localityTimeout}
};
if (({!isNull _x && {!local _x}} count _cargoCarriers) > 0) exitWith {
	_packerbox setVariable ["D207_packBusy",false,true];
	["The server could not take ownership of the vehicle. Try again after everyone has exited it."] call _sendMessage;
};
/*
	Unload all BoxLoader / ViV cargo before moving
	the original vehicle.
	Example:
	    _vehicle setVehicleCargo objNull;
	unloads all ViV cargo from that carrier.
*/
private _loadedCargoCount = 0;
{
	private _loadedCargo = getVehicleCargo _x;
	_loadedCargoCount = _loadedCargoCount + count _loadedCargo;
	if (_loadedCargo isNotEqualTo []) then {_x setVehicleCargo objNull;};
} forEach _cargoCarriers;
// Give the engine time to finish unloading cargo.
if (_loadedCargoCount > 0) then
{
	private _unloadTimeout = time + 5;
	waitUntil {sleep 0.1;private _cargoRemaining = {getVehicleCargo _x isNotEqualTo []}count _cargoCarriers;_cargoRemaining isEqualTo 0 || {time >= _unloadTimeout}};
	private _cargoStillLoaded = {getVehicleCargo _x isNotEqualTo []} count _cargoCarriers;
	if (_cargoStillLoaded > 0) exitWith {_packerbox setVariable ["D207_packBusy",false,true];["Unable to unload all cargo from the vehicle."] call _sendMessage;};
};
// Mark the vehicle as packed before moving it.
_victopack setVariable ["D207_isPacked",true,true];
// Stop physics and damage before teleporting. The vehicle is still visible at this point.
_victopack allowDamage false;
_victopack enableSimulationGlobal false;
_victopack setVelocity [0, 0, 0];
/*
	Move the original vehicle to the holding location
	BEFORE hiding it.
	It stays directly above its original location,
	but 5,000 metres up.
*/
private _holdingPosition = [_originalPosition select 0,_originalPosition select 1,5000];
_victopack setPosATL _holdingPosition;
_victopack setVelocity [0, 0, 0];
// Allow the move to propagate before hiding it.
sleep 0.25;
_victopack hideObjectGlobal true;
// Create the movable transport box at the vehicle's original position.
private _packbox = createVehicle ["B_Slingload_01_Cargo_F",[0, 0, 0],[],0,"CAN_COLLIDE"];
if (isNull _packbox) exitWith
{
	_victopack setVectorDirAndUp [_originalVectorDir,_originalVectorUp];
	_victopack setPosATL _originalPosition;
	_victopack hideObjectGlobal false;
	_victopack enableSimulationGlobal true;
	_victopack allowDamage true;
	_victopack setVariable ["D207_isPacked",false,true];
	_packerbox setVariable ["D207_packBusy",false,true];
	["Unable to create the transport box."] call _sendMessage;
};
clearItemCargoGlobal _packbox;
clearMagazineCargoGlobal _packbox;
clearBackpackCargoGlobal _packbox;
clearWeaponCargoGlobal _packbox;
_packbox setDir _originalDirection;
_packbox setPosATL _originalPosition;
_packbox setVelocity [0, 0, 0];
// Store packed vehicle details on the transport box.
_packbox setVariable ["D207_packedVehicle",_victopack,true];
_packbox setVariable ["D207_packedDisplayName",_displayName,true];
_packbox setVariable ["D207_packedType",_packingType,true];
_packbox setVariable ["D207_packedVectorDir",_originalVectorDir,true];
_packbox setVariable ["D207_packedVectorUp",_originalVectorUp,true];
// The packer is no longer needed.
deleteVehicle _packerbox;
// Add the ACE unpack action.
["ADD_ACTION",_packbox] remoteExec ["D207_fnc_unboxvic",0,_packbox];
private _cargoMessage = if (_loadedCargoCount > 0) then {format [" %1 loaded cargo object(s) were unloaded first.",_loadedCargoCount]} else {""};
[ format ["%1 has been packed.%2",_displayName,_cargoMessage]] call _sendMessage;