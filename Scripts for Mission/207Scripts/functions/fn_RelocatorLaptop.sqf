params [
	["_mode", "", [""]],
	["_Laptop", objNull]
];
// ["CREATE", this] spawn D207_fnc_RelocatorLaptop;
switch (_mode) do
{
	case "CREATE":
	{
		_Respawn = ["Respawn", "<t color='#207207'>Respawn LapTop</t>","",{nil}, {true}, {}, [], [0, 0, 0], 7] call ace_interact_menu_fnc_createAction; 
		[_Laptop, 0, [], _Respawn]  call ace_interact_menu_fnc_addActionToObject; 
		_Ping = ["Ping", "<t color='#00FFEA'>Ping For Reinsertion</t>","",{[] spawn D207_fnc_Reinsertionping;}, {true}] call ace_interact_menu_fnc_createAction; 
		[_Laptop, 0, ["Respawn"], _Ping]  call ace_interact_menu_fnc_addActionToObject; 
		_Heal = ["HealBase", "<t color='#00FF00'>Heal</t>","",{[objNull, player] call ace_medical_treatment_fnc_fullHeal;}, {true}] call ace_interact_menu_fnc_createAction; 
		[_Laptop, 0, ["Respawn"], _Heal]  call ace_interact_menu_fnc_addActionToObject; 
		_MoveToFOB = ["MoveToFOB", "<t color='#ff0000'>Move To FOB</t>","",{["FOB"] spawn D207_fnc_RelocatorLaptop;}, {!isNil "FOBTELE"}] call ace_interact_menu_fnc_createAction; 
		[_Laptop, 0, ["Respawn"], _MoveToFOB]  call ace_interact_menu_fnc_addActionToObject; 
		_MoveToRelocator = ["MoveToRelocator", "<t color='#ff0000'>Move To Spawn Relocator</t>","",{["Relocator"] spawn D207_fnc_RelocatorLaptop;}, {missionNamespace getVariable "SpawnRelocator" && !isNil "Relocator"}] call ace_interact_menu_fnc_createAction; 
		[_Laptop, 0, ["Respawn"], _MoveToRelocator]  call ace_interact_menu_fnc_addActionToObject;
	};
	case "FOB":
	{
		call BIS_fnc_VRFadeOut;
		sleep 1;
		Player setPos (getPos FOBTELE);
		sleep 1;
		call BIS_fnc_VRFadeIn;
	};
	case "Relocator":
	{
		call BIS_fnc_VRFadeOut;
		sleep 1;
		Player setPos (getPos Relocator);
		sleep 1;
		call BIS_fnc_VRFadeIn;
	};
};