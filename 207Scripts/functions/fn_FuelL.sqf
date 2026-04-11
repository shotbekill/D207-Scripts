_fueltankL = "Boxloader_drumpallet_fuel" createVehicle position player;
sleep 1;
[_fueltankL, 5000] remoteExec ["ace_refuel_fnc_makeSource", 2];
[_fueltankL, 5000] remoteExec ["ace_refuel_fnc_setFuel", 2];