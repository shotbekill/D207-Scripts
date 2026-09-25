if (!hasInterface) exitWith {};

private _soundEnabled = profileNamespace getVariable ["D207_Op_Sound", false];
private _outroEnabled = profileNamespace getVariable ["D207_Op_Outro", false];

if (_outroEnabled) then {
    // Add outro code here.
    // If there is sound, gate it with: if (_soundEnabled) then { ... };
};
