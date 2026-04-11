params ["_unit"];
_uid = getPlayerUID _unit;
if (_uid in D207_ZeusUID) then {
_group = createGroup sideLogic;
_name = name _unit;
_NameGroup = format ["%1 Zeus", _name];
[_group, [_NameGroup]] remoteExec ["setGroupId", 0];
_curator = _group createUnit ["ModuleCurator_F", [0,0,0], [], 0, "NONE"];
_unit assignCurator _curator;
_curator addCuratorAddons activatedAddons;
_curator addCuratorEditableObjects [allMissionObjects "AllVehicles", true];
} else {_unit setDamage 1;};