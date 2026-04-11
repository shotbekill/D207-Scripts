if (isServer) then {
missionNamespace setVariable ["GameStop", false, true];
};
if (hasInterface) then {
[parseText "<t align='center' shadow='2' size='4'><t color='#207207'>Game On</t></t><br/>", [0,0.7,1,0.5], nil, 7, 0.7, 0] spawn BIS_fnc_textTiles;
};


/*
hint parseText "<t size='2.0'>Game On</t>";
sleep 10; 
hintSilent "";
*/