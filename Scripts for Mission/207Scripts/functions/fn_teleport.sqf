params [["_type", 0, [0]]];

if (_type == 1) then {
	call BIS_fnc_VRFadeOut;
	sleep 1;
	Player setPos (getPos FOBTELE);
	sleep 1;
	call BIS_fnc_VRFadeIn;
};

if (_type == 2) then {
	call BIS_fnc_VRFadeOut;
	sleep 1;
	Player setPos (getPos Relocator);
	sleep 1;
	call BIS_fnc_VRFadeIn;
};
