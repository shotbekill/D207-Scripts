if (isServer) then {
_fortifylist = [
["Land_HBarrier_Big_F", 5, "H-Barrier"],
["Land_HBarrier_3_F", 5, "H-Barrier"],
["Land_HBarrier_5_F", 5, "H-Barrier"],
["Land_HBarrierWall4_F", 5, "H-Barrier"],
["Land_HBarrierWall6_F", 5, "H-Barrier"],
["Land_HBarrierWall_corner_F", 5, "H-Barrier"],
["Land_HBarrierWall_corridor_F", 5, "H-Barrier"],
["Land_HBarrierTower_F", 5, "H-Barrier"],
["Land_BagFence_Short_F", 5, "Sand Bags"],
["Land_BagFence_Long_F", 5, "Sand Bags"],
["Land_BagFence_Round_F", 5, "Sand Bags"],
["Land_BagFence_Corner_F", 5, "Sand Bags"],
["Land_SandbagBarricade_01_half_F", 5, "Sand Bags"],
["Land_SandbagBarricade_01_F", 5, "Sand Bags"],
["Land_SandbagBarricade_01_hole_F", 5, "Sand Bags"],
["RoadCone_F", 5, "Checkpoint"],
["RoadCone_L_F", 5, "Checkpoint"],
["Land_Razorwire_F", 5, "Checkpoint"],
["Land_BarGate_F", 5, "Checkpoint"],
["Land_DragonsTeeth_01_1x1_new_F", 5, "Checkpoint"],
["Land_DragonsTeeth_01_4x2_new_F", 5, "Checkpoint"],
["Land_CzechHedgehog_01_new_F", 5, "Checkpoint"],
["Land_ConcreteHedgehog_01_F", 5, "Checkpoint"],
["Land_BagBunker_Small_F", 10, "Checkpoint"],
["Land_BagBunker_Large_F", 15, "Checkpoint"],
["Land_BagBunker_Tower_F", 15, "Checkpoint"],
["Land_SignWarning_01_CheckpointAhead_F", 5, "Checkpoint"],
["Land_CanvasCover_01_F", 15, "Base"],
["Land_CanvasCover_02_F", 15, "Base"],
["Land_HelipadRescue_F", 5, "Signs"],
["Land_HelipadCircle_F", 5, "Signs"],
["Land_HelipadSquare_F", 5, "Signs"],
["AreaMarker_01_F", 5, "Signs"],
["Land_SignM_WarningMilitaryArea_english_F", 5, "Signs"],
["Land_Sign_MinesDanger_English_F", 5, "Signs"],
["Land_SignM_taxi_F", 5, "Signs"],
["Land_SignM_WarningMilitaryVehicles_english_F", 5, "Signs"],
["Land_Rail_ConcreteRamp_F", 50, "Bridge"],
["Land_Rail_Bridge_40_F", 50, "Bridge"],
["Land_Sidewalk_01_8m_F", 50, "Bridge"],
["Land_Canal_Dutch_01_bridge_F", 50, "Bridge"],
["TFAR_Land_Communication_F", 25, "misc"],
["Land_Mil_WiredFence_Gate_F", 5, "misc"],
["Land_Mil_WiredFence_F", 5, "misc"],
["Land_New_WiredFence_5m_F", 5, "misc"],
["Land_New_WiredFence_10m_F", 5, "misc"],
["FLAG_adfrc_F", 5, "misc"],
["Land_GH_Platform_F", 5, "misc"],
["Land_GH_Stairs_F", 5, "misc"],
["Land_PierLadder_F", 5, "misc"],
["Land_LampHalogen_F", 5, "misc"],
["RHS_Stinger_AA_pod_WD", 25]
];

[west, 5000, _fortifylist] call ace_fortify_fnc_registerObjects;

[east, 5000, _fortifylist] call ace_fortify_fnc_registerObjects;

[independent, 5000, _fortifylist] call ace_fortify_fnc_registerObjects;
};

if (missionNamespace getVariable "Startup" != true) then {missionNamespace setVariable ["Startup", true, true];};
