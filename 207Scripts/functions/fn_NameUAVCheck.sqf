params ["_nameToCheck"];
private _nameTaken = true;
{
    if (groupId _x == _nameToCheck) exitWith {
        _nameTaken = false;
    };
} forEach allGroups;
_nameTaken;