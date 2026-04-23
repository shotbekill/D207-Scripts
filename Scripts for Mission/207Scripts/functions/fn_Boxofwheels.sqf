_boxname = "Land_Boxloader_Crate_1" createVehicle position player;
[_boxname, 20] call ace_cargo_fnc_setSpace;
for "_x" from 0 to 9 do {
_wheel = "ACE_Wheel" createVehicle position player;
[_wheel, _boxname, true] call ace_cargo_fnc_loadItem;
};
systemChat "A Box of 10 wheels has been spawned near you.";