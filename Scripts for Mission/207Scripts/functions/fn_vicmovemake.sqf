params ["_packerbox"];
_packerbox addAction ["Pack Nearest Land Vehicle", {[_this select 3] spawn D207_fnc_vicmove;}, _packerbox, 1.5, false, true, "", "true", 5, false, "", ""];
_packerbox addAction ["Pack Nearest Airframe", {[_this select 3] spawn D207_fnc_vicmoveAir;}, _packerbox, 1.5, false, true, "", "true", 5, false, "", ""];