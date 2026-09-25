disableSerialization;

if (isNull _box) exitWith {
	hint "No box/object was provided.";
};

// ======================================================================
// BUILD ITEM LIST
// ======================================================================

private _itemList = [];
// Function to add cargo and combine duplicate classnames
private _addCargo = {
	params ["_cargo"];
	_cargo params ["_classes", "_counts"];
	{
		private _className = _x;
		private _count = _counts # _forEachIndex;
		private _existingIndex = _itemList findIf {(_x # 0) isEqualTo _className};
		if (_existingIndex == -1) then {
			_itemList pushBack [_className, _count];
		} else {
			private _current = _itemList # _existingIndex;
			_current set [1,(_current # 1) + _count];
			_itemList set [_existingIndex, _current];
		};
	} forEach _classes;
};
// Items
[getItemCargo _box] call _addCargo;
// Magazines
[getMagazineCargo _box] call _addCargo;
// Weapons
[getWeaponCargo _box] call _addCargo;
// Backpacks
[getBackpackCargo _box] call _addCargo;

// ======================================================================
// FORMAT OUTPUT
// ======================================================================

private _newLine = toString [13, 10];
private _output = "_itemlist = [" + _newLine;
{
	_x params ["_className", "_count"];
	private _comma = ",";
	if (_forEachIndex == ((count _itemList) - 1)) then {_comma = "";};
	_output = _output + format ["	[""%1"", %2]%3%4",_className,_count,_comma,_newLine];
} forEach _itemList;
_output = _output + "];";

// ======================================================================
// DISPLAY OUTPUT
// ======================================================================

// Find Zeus display
private _parentDisplay = findDisplay 312;
// Fallback to main game display
if (isNull _parentDisplay) then {_parentDisplay = findDisplay 46;};
if (isNull _parentDisplay) exitWith {hint "Could not find Zeus/Game display.";};
// Create output window
private _display = _parentDisplay createDisplay "RscDisplayEmpty";
// Background
private _background = _display ctrlCreate ["RscText", -1];
_background ctrlSetPosition [
	safeZoneX + (safeZoneW * 0.10),
	safeZoneY + (safeZoneH * 0.10),
	safeZoneW * 0.80,
	safeZoneH * 0.80
];
_background ctrlSetBackgroundColor [0, 0, 0, 0.90];
_background ctrlCommit 0;
// Title
private _title = _display ctrlCreate ["RscText", -1];
_title ctrlSetPosition [
	safeZoneX + (safeZoneW * 0.11),
	safeZoneY + (safeZoneH * 0.11),
	safeZoneW * 0.78,
	safeZoneH * 0.05
];
_title ctrlSetText format ["D207 Box Export - %1, Press CTRL+C to copy.",typeOf _box];
_title ctrlSetFontHeight 0.035;
_title ctrlCommit 0;
// Multi-line text box
private _edit = _display ctrlCreate ["RscEditMulti", -1];
_edit ctrlSetPosition [
	safeZoneX + (safeZoneW * 0.11),
	safeZoneY + (safeZoneH * 0.17),
	safeZoneW * 0.78,
	safeZoneH * 0.63
];
_edit ctrlSetBackgroundColor [0.05, 0.05, 0.05, 1];
_edit ctrlSetFont "EtelkaMonospacePro";
_edit ctrlSetFontHeight 0.025;
_edit ctrlSetText _output;
_edit ctrlCommit 0;
// Close button
private _closeButton = _display ctrlCreate ["RscButton", -1];
_closeButton ctrlSetPosition [
	safeZoneX + (safeZoneW * 0.79),
	safeZoneY + (safeZoneH * 0.82),
	safeZoneW * 0.10,
	safeZoneH * 0.05
];
_closeButton ctrlSetText "Close";
_closeButton ctrlCommit 0;
_closeButton ctrlAddEventHandler ["ButtonClick",{(ctrlParent (_this # 0)) closeDisplay 1;}];
// Select all text automatically
ctrlSetFocus _edit;
_edit ctrlSetTextSelection [0,count _output];

hint "Box contents exported. Press CTRL+C to copy.";