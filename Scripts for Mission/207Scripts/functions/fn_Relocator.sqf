params [
    ["_mode", "", [""]],
    ["_vehicle", objNull, [objNull]],
    ["_caller", objNull, [objNull]]
];

switch (toUpper _mode) do {
    case "CREATE": {
        if (!hasInterface || {isNull _vehicle}) exitWith {};
        if (_vehicle getVariable ["D207_RelocatorActionsAdded", false]) exitWith {};
        _vehicle setVariable ["D207_RelocatorActionsAdded", true];

        private _mainAction = ["D207_Relocator", "<t color='#207207'>Relocator</t>", "", {nil}, {true}, {}, [], [0,0,-1], 7] call ace_interact_menu_fnc_createAction;
        [_vehicle, 0, [], _mainAction] call ace_interact_menu_fnc_addActionToObject;

        private _checkAction = ["D207_RelocatorCheck", "<t color='#ff0000'>Check LOC</t>", "",
            {["CHECKLOC", _target, _player] spawn D207_fnc_Relocator;},
            {!(missionNamespace getVariable ["SpawnRelocator", false])}
        ] call ace_interact_menu_fnc_createAction;
        [_vehicle, 0, ["D207_Relocator"], _checkAction] call ace_interact_menu_fnc_addActionToObject;

        private _setupAction = ["D207_RelocatorSetup", "<t color='#ff0000'>Set Up Relocator</t>", "",
            {["SETUP", _target, _player] remoteExec ["D207_fnc_Relocator", 2];},
            {!(missionNamespace getVariable ["SpawnRelocator", false])}
        ] call ace_interact_menu_fnc_createAction;
        [_vehicle, 0, ["D207_Relocator"], _setupAction] call ace_interact_menu_fnc_addActionToObject;

        private _packAction = ["D207_RelocatorPack", "<t color='#ff0000'>Pack Up Relocator</t>", "",
            {["PACK", _target, _player] remoteExec ["D207_fnc_Relocator", 2];},
            {missionNamespace getVariable ["SpawnRelocator", false] && {!isNull (missionNamespace getVariable ["Relocator", objNull])}}
        ] call ace_interact_menu_fnc_createAction;
        [_vehicle, 0, ["D207_Relocator"], _packAction] call ace_interact_menu_fnc_addActionToObject;
    };

    case "CHECKLOC": {
        if (!hasInterface || {isNull _vehicle}) exitWith {};
        private _selectors = [];
        {
            _x params ["_class", "_offset"];
            private _obj = _class createVehicleLocal (_vehicle modelToWorld _offset);
            _obj setDir getDir _vehicle;
            _selectors pushBack _obj;
        } forEach [
            ["VR_3DSelector_01_incomplete_F", [-12.5,22.75,0]],
            ["VR_3DSelector_01_incomplete_F", [3.5,22.75,0]],
            ["VR_3DSelector_01_incomplete_F", [-12.5,-16.75,0]],
            ["VR_3DSelector_01_incomplete_F", [3.5,-16.75,0]],
            ["VR_3DSelector_01_exit_F", [-4.5,-4.75,0]]
        ];
        uiSleep 10;
        {deleteVehicle _x;} forEach _selectors;
    };

    case "SETUP": {
        if (!isServer || {isNull _vehicle} || {isNull _caller} || {!isPlayer _caller}) exitWith {};
        if (isRemoteExecuted && {remoteExecutedOwner != owner _caller}) exitWith {};
        if (_caller distance _vehicle > 10) exitWith {};
        if (crew _vehicle isNotEqualTo []) exitWith {
            ["<t color='#ff0000'>Everyone must exit the vehicle before setting up the Relocator.</t>"] remoteExecCall ["D207_fnc_ClientHint", owner _caller];
        };
        if (!local _vehicle) then {
            _vehicle setOwner 2;
            private _localityTimeout = diag_tickTime + 2;
            waitUntil {uiSleep 0.05; local _vehicle || {diag_tickTime >= _localityTimeout}};
        };
        if (!local _vehicle) exitWith {
            ["<t color='#ff0000'>The server could not take ownership of the Relocator vehicle. Try again after everyone has exited it.</t>"] remoteExecCall ["D207_fnc_ClientHint", owner _caller];
        };
        if (missionNamespace getVariable ["SpawnRelocator", false]) exitWith {
            ["<t color='#ff0000'>A Relocator is already set up. Pack it before setting up another.</t>"] remoteExecCall ["D207_fnc_ClientHint", owner _caller];
        };

        missionNamespace setVariable ["SpawnRelocator", true, true];
        _vehicle allowDamage false;
        _vehicle enableSimulationGlobal false;
        _vehicle setVariable ["D207_RelocatorSetupBusy", true, true];
        ["<t color='#207207'>Setting up Spawn Relocator. This will take some time.</t>"] remoteExecCall ["D207_fnc_ClientHint", owner _caller];

        private _createdObjects = [];
        private _fnc_snapObjectToSurface = {
            params [
                ["_obj", objNull, [objNull]],
                ["_alignToSlope", false, [false]],
                ["_zOffset", 0, [0]]
            ];
            if (isNull _obj) exitWith {};
            private _posASL = getPosASL _obj;
            private _xPos = _posASL select 0;
            private _yPos = _posASL select 1;
            private _hits = lineIntersectsSurfaces [[_xPos,_yPos,1000], [_xPos,_yPos,-1000], _obj, objNull, true, 1, "GEOM", "NONE"];
            private _surfaceASL = [_xPos, _yPos, getTerrainHeightASL [_xPos,_yPos]];
            private _surfaceNormal = surfaceNormal [_xPos,_yPos];
            if (_hits isNotEqualTo []) then {
                _surfaceASL = (_hits select 0) select 0;
                _surfaceNormal = (_hits select 0) select 1;
            };
            _obj setPosASL [_xPos, _yPos, (_surfaceASL select 2) + _zOffset];
            if (_alignToSlope) then {_obj setVectorUp _surfaceNormal;};
        };
        private _fnc_spawnGroundObject = {
            params [
                ["_anchor", objNull, [objNull]],
                ["_className", "", [""]],
                ["_offset", [0,0,0], [[]]],
                ["_dirOffset", 0, [0]],
                ["_alignToSlope", false, [false]],
                ["_zOffset", 0, [0]]
            ];
            private _spawned = [[_anchor,"GROUND"], _className, 1, _offset, _dirOffset, {0}, false] call BIS_fnc_spawnObjects;
            private _obj = _spawned param [0, objNull];
            if (!isNull _obj) then {
                [_obj, _alignToSlope, _zOffset] call _fnc_snapObjectToSurface;
                _createdObjects pushBack _obj;
            };
            _obj
        };

        uiSleep 60;
        {
            _x params ["_className", "_offset", "_dirOffset", ["_delay", 1]];
            [_vehicle, _className, _offset, _dirOffset] call _fnc_spawnGroundObject;
            uiSleep _delay;
        } forEach [
            ["Land_HBarrier_5_F", [-0.75,6.25,0], 0],
            ["Land_HBarrier_5_F", [2.75,4.25,0], 90],
            ["Land_HBarrier_5_F", [2.75,-1.5,0], 90],
            ["Land_HBarrier_5_F", [2.75,-7.25,0], 90],
            ["Land_HBarrier_5_F", [2.75,-13,0], 90],
            ["Land_HBarrier_3_F", [1.75,-16.5,0], 0],
            ["Land_HBarrier_3_F", [-11,-16.5,0], 0],
            ["Land_HBarrier_5_F", [-12,-13,0], 90],
            ["Land_HBarrier_5_F", [-12,-7.25,0], 90],
            ["Land_HBarrier_5_F", [-12,-1.5,0], 90],
            ["Land_HBarrier_5_F", [-12,4.25,0], 90],
            ["Land_HBarrier_5_F", [-8.5,6.25,0], 0, 6],
            ["Land_SandbagBarricade_01_F", [-4.5,-16.75,0], 180, 6],
            ["Land_MedicalTent_01_MTP_closed_F", [-4.5,-11.75,0], 0, 6]
        ];

        private _table = [_vehicle, "Land_CampingTable_small_F", [-3,4.75,0], 180] call _fnc_spawnGroundObject;
        uiSleep 6;
        private _laptopSpawn = [[_table,"TOP"], "Land_Laptop_device_F", 1, [0,0,0], 45, {0}, false] call BIS_fnc_spawnObjects;
        private _laptop = _laptopSpawn param [0, objNull];
        if (!isNull _laptop) then {
            _createdObjects pushBack _laptop;
            ["CREATE", _laptop] remoteExec ["D207_fnc_RelocatorLaptop", -2, _laptop];
        };

        [_vehicle, "Land_HelipadRescue_F", [-4.5,15.5,0], 0] call _fnc_spawnGroundObject;
        uiSleep 10;
        private _selector = [_vehicle, "VR_3DSelector_01_exit_F", [-4.5,-4.75,0], 0] call _fnc_spawnGroundObject;
        uiSleep 15;

        if (!isNull _selector) then {
            _selector hideObjectGlobal true;
            missionNamespace setVariable ["Relocator", _selector, true];
        };
        _vehicle setVariable ["D207_RelocatorObjects", _createdObjects, true];
        _vehicle setVariable ["D207_RelocatorSetupBusy", false, true];
        ["<t color='#207207'>Spawn Relocator has been set up.</t>"] remoteExecCall ["D207_fnc_ClientHint", owner _caller];
    };

    case "PACK": {
        if (!isServer || {isNull _vehicle} || {isNull _caller} || {!isPlayer _caller}) exitWith {};
        if (isRemoteExecuted && {remoteExecutedOwner != owner _caller}) exitWith {};
        if (_caller distance _vehicle > 10) exitWith {};
        if !(missionNamespace getVariable ["SpawnRelocator", false]) exitWith {};
        if (_vehicle getVariable ["D207_RelocatorSetupBusy", false]) exitWith {
            ["<t color='#ff0000'>Relocator setup is still in progress.</t>"] remoteExecCall ["D207_fnc_ClientHint", owner _caller];
        };
        if (!local _vehicle) then {
            _vehicle setOwner 2;
            private _localityTimeout = diag_tickTime + 2;
            waitUntil {uiSleep 0.05; local _vehicle || {diag_tickTime >= _localityTimeout}};
        };
        if (!local _vehicle) exitWith {
            ["<t color='#ff0000'>The server could not take ownership of the Relocator vehicle.</t>"] remoteExecCall ["D207_fnc_ClientHint", owner _caller];
        };

        ["<t color='#207207'>Packing Spawn Relocator.</t>"] remoteExecCall ["D207_fnc_ClientHint", owner _caller];
        missionNamespace setVariable ["Relocator", nil, true];
        missionNamespace setVariable ["SpawnRelocator", false, true];

        private _createdObjects = _vehicle getVariable ["D207_RelocatorObjects", []];
        {
            if (!isNull _x) then {deleteVehicle _x;};
        } forEach _createdObjects;
        _vehicle setVariable ["D207_RelocatorObjects", [], true];

        uiSleep 10;
        _vehicle allowDamage true;
        _vehicle enableSimulationGlobal true;
        ["<t color='#207207'>Spawn Relocator has been packed.</t>"] remoteExecCall ["D207_fnc_ClientHint", owner _caller];
    };
};
