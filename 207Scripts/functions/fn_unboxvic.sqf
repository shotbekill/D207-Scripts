params ["_displayName","_victopack","_packbox"];
_vicname = format ["UnPack %1", _displayName];
_packbox addAction [_vicname, {
systemChat format ["Unpacking %1", (_this select 3 select 2)];
_victopack = _this select 3 select 1;
_boxpos = getPos (_this select 3 select 0);
deleteVehicle _this select 3 select 0;
_victopack setPos _boxpos;
sleep 2;
_victopack hideObjectGlobal false;
_victopack enableSimulation true;
sleep 2;
_victopack allowDamage true;
systemChat format ["Unpacking of %1 done", (_this select 3 select 2)];
}, [_packbox,_victopack,_displayName], 1.5, false, true, "", "true", 8, false, "", ""];