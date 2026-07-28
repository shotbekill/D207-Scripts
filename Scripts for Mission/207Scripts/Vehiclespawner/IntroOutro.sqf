disableSerialization;
// find Display
private _display = findDisplay 8300;
if (isNull _display) exitWith {
	hint "Intro Outro menu not found.";
};

private _ctrlIntro = _display displayCtrl 2800;
private _ctrlOutro = _display displayCtrl 2801;
private _ctrlSound = _display displayCtrl 2802;

private _IntroCheck = cbChecked _ctrlIntro;
private _OutroCheck = cbChecked _ctrlOutro;
private _SoundCheck = cbChecked _ctrlSound;

if (_IntroCheck) then {profileNamespace setVariable ["D207_Op_Intro", true];} else {profileNamespace setVariable ["D207_Op_Intro", false];};
if (_OutroCheck) then {profileNamespace setVariable ["D207_Op_Outro", true];} else {profileNamespace setVariable ["D207_Op_Outro", false];};
if (_SoundCheck) then {profileNamespace setVariable ["D207_Op_Sound", true];} else {profileNamespace setVariable ["D207_Op_Sound", false];};
saveProfileNamespace;
closeDialog 1;
private _Intro = "Out Of";
private _Outro = "Out Of";
private _Sound = "Out Of";
if (_IntroCheck) then {_Intro = "In To";};
if (_OutroCheck) then {_Outro = "In To";};
if (_SoundCheck) then {_Sound = "In To";};

private _text1 = parseText format ["You have Opted %1 Intro's.", _Intro];
private _text2 = parseText format ["You have Opted %1 Outro's.", _Outro];
private _text3 = parseText format ["You have Opted %1 Sound's.", _Sound];
private _text4 = parseText format ["Setting's saved to Profile"];
hint composeText [_text1, lineBreak, _text2, lineBreak, _text3, lineBreak, _text4];







