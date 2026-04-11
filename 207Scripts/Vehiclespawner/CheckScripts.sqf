closeDialog 1;

_backInit = ctrlText 1401;
_backMain = ctrlText 1402;
_backConfig = ctrlText 1403;

_Scriptupdate = "9-04-26";
_PlayerConfig = player getVariable "D207_PlayerConfig";
_ServerConfig = missionNamespace getVariable "D207_ServerConfig";
_PlayerConfigInit = player getVariable "D207_PlayerConfigInit";
_ServerConfigInit = missionNamespace getVariable "D207_ServerConfigInit";
_PlayerMain = player getVariable "D207_PlayerMain";
_ServerMain = missionNamespace getVariable "D207_ServerMain";
_init = [];
_Main = [];
_Config = [];
_Backgr = [];

if (_PlayerConfigInit == _backInit && _ServerConfigInit == _backInit) then {_init = parseText format ["Good: %1",_backInit];} else {_init = parseText format ["Bad:Player=%1 Server=%2 Should be %3", _PlayerConfigInit,_ServerConfigInit,_backInit];};
if (_PlayerMain == _backMain && _ServerMain == _backMain) then {_Main = parseText format ["Good: %1",_backMain];} else {_Main = parseText format ["Bad:Player=%1 Server=%2 Should be %3", _PlayerMain,_ServerMain,_backMain];};
if (_PlayerConfig == _backConfig && _ServerConfig == _backConfig) then {_Config = parseText format ["Good: %1",_backConfig];} else {_Config = parseText format ["Bad:Player=%1 Server=%2 Should be %3", _PlayerConfig,_ServerConfig,_backConfig];};

_hinttext1 = parseText format ["Script Check is at %1", _Scriptupdate];
_hinttext2 = parseText format ["Init Script's Are %1", _init];
_hinttext3 = parseText format ["Main Script's Are %1", _Main];
_hinttext5 = parseText format ["Config Script's Are %1", _Config];
hint composeText [_hinttext1, lineBreak, _hinttext2, lineBreak, _hinttext3, lineBreak, _hinttext5];