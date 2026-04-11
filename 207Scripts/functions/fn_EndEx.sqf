if (isServer) then {
missionNamespace setVariable ["LoadIn", false, true];
missionNamespace setVariable ["Gameon", false, true];
missionNamespace setVariable ["GameStop", false, true];
missionNamespace setVariable ["EndEx", true, true];
};
if (hasInterface) then {
_EndExPos = mapGridPosition EndExPos;
[parseText "<t align='center' shadow='2' size='4'><t color='#207207'>EndEx</t></t><br/>", [0,0.7,1,0.5], nil, 7, 0.7, 0] spawn BIS_fnc_textTiles;
sleep 5;
_EndExText = parseText format ["<t align='center' shadow='2' size='4'><t color='#207207'>EndEx marked on map at Grid%1</t></t><br/>", _EndExPos];
[_EndExText, [0,0.7,1,0.5], nil, 7, 0.7, 0] spawn BIS_fnc_textTiles;
};