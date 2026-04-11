class VehicleSpawnerStart
{
	idd = 8000;
	
	class controls
	{
		class baseFrame: RscFrame
		{
			idc = 1800;
			x = 0.434767 * safezoneW + safezoneX;
			y = 0.335 * safezoneH + safezoneY;
			w = 0.115116 * safezoneW;
			h = 0.253 * safezoneH;
		};
		class ButtonPlatoonVehicle: RscButton
		{
			idc = 1601;
			action = "D207_VehicleSpawnerType = 1; execVM '207Scripts\Vehiclespawner\OpenDialog.sqf';";
			text = "Platoon Vehicle's"; //--- ToDo: Localize;
			x = 0.442442 * safezoneW + safezoneX;
			y = 0.401 * safezoneH + safezoneY;
			w = 0.0997674 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class ButtonFoxtrotVehicle: RscButton
		{
			idc = 1602;
			action = "D207_VehicleSpawnerType = 2; execVM '207Scripts\Vehiclespawner\OpenDialog.sqf';";
			text = "Foxtrot Vehicle's"; //--- ToDo: Localize;
			x = 0.442442 * safezoneW + safezoneX;
			y = 0.445 * safezoneH + safezoneY;
			w = 0.0997674 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class ButtonHawkeyeVehicle: RscButton
		{
			idc = 1603;
			action = "D207_VehicleSpawnerType = 3; execVM '207Scripts\Vehiclespawner\OpenDialog.sqf';";
			text = "Hawkeye Vehicle's"; //--- ToDo: Localize;
			x = 0.442442 * safezoneW + safezoneX;
			y = 0.489 * safezoneH + safezoneY;
			w = 0.0997674 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class ButtonDrone: RscButton
		{
			idc = 1604;
			action = "D207_VehicleSpawnerType = 4; execVM '207Scripts\Vehiclespawner\OpenDialog.sqf';";
			text = "Drone's"; //--- ToDo: Localize;
			x = 0.442442 * safezoneW + safezoneX;
			y = 0.533 * safezoneH + safezoneY;
			w = 0.0460465 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class ButtonCanSpawn: RscButton
		{
			idc = 1605;
			action = "execVM '207Scripts\Vehiclespawner\canSpawn.sqf';";
			text = "Can Spawn?"; //--- ToDo: Localize;
			x = 0.496163 * safezoneW + safezoneX;
			y = 0.346 * safezoneH + safezoneY;
			w = 0.0460465 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class ButtonCheckSpawn: RscButton
		{
			idc = 1606;
			action = "execVM '207Scripts\Vehiclespawner\CheckSpawn.sqf';";
			text = "Check Spawn"; //--- ToDo: Localize;
			x = 0.442442 * safezoneW + safezoneX;
			y = 0.346 * safezoneH + safezoneY;
			w = 0.0460465 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class ButtonCancel: RscButton
		{
			idc = 1607;
			action = "closeDialog 2;";
			text = "Cancel"; //--- ToDo: Localize;
			x = 0.496163 * safezoneW + safezoneX;
			y = 0.533 * safezoneH + safezoneY;
			w = 0.0460465 * safezoneW;
			h = 0.033 * safezoneH;
		};
	};
};

class VehicleSpawner
{
	idd = 8100;
	
	class controls
	{
		class baseFrame: RscFrame
		{
			idc = 1800;
			x = 5.5 * GUI_GRID_W + GUI_GRID_X;
			y = 5.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 30.5 * GUI_GRID_W;
			h = 8 * GUI_GRID_H;
		};
		class ButtonSpawn: RscButton
		{
			idc = 1600;
			action = "execVM '207Scripts\Vehiclespawner\Spawn.sqf';";
			text = "Spawn Vehicle";
			x = 29 * GUI_GRID_W + GUI_GRID_X;
			y = 6 * GUI_GRID_H + GUI_GRID_Y;
			w = 6 * GUI_GRID_W;
			h = 2 * GUI_GRID_H;
		};
		class ButtonCheck: RscButton
		{
			idc = 1601;
			action = "execVM '207Scripts\Vehiclespawner\StartDialog.sqf';closeDialog 2;";
			text = "Back";
			x = 29 * GUI_GRID_W + GUI_GRID_X;
			y = 11 * GUI_GRID_H + GUI_GRID_Y;
			w = 6 * GUI_GRID_W;
			h = 2 * GUI_GRID_H;
		};
		class ButtonCancel: RscButton
		{
			idc = 1602;
			action = "execVM '207Scripts\Vehiclespawner\CheckSpawn.sqf';";
			text = "Check Spawn";
			x = 29 * GUI_GRID_W + GUI_GRID_X;
			y = 8.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 6 * GUI_GRID_W;
			h = 2 * GUI_GRID_H;
		};
		class BoxList: RscListBox
		{
			idc = 1500;
			x = 6 * GUI_GRID_W + GUI_GRID_X;
			y = 6 * GUI_GRID_H + GUI_GRID_Y;
			w = 22 * GUI_GRID_W;
			h = 7 * GUI_GRID_H;
			class ListScrollBar
			{
				color[] = {1,1,1,1};
				autoScrollEnabled = 1;
				colorActive[] = {1,1,1,1};
				colorDisabled[] = {1,1,1,0.3};
				thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
				arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
				arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
				border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
				shadow = 0;
				scrollSpeed = 0.06;
				width = 0;
				height = 0;
				autoScrollSpeed = -1;
				autoScrollDelay = 5;
				autoScrollRewind = 0;
			};
		};
	};
};

class CanSpawnVehicle
{
	idd = 8200;
	
	class controls
	{
		class RscFrame_1800: RscFrame
		{
			idc = 1800;

			x = 0.457791 * safezoneW + safezoneX;
			y = 0.302 * safezoneH + safezoneY;
			w = 0.0959302 * safezoneW;
			h = 0.341 * safezoneH;
			colorBackground[] = {0,0,0,0.3};
		};
		class PlatoonVehicleText: RscText
		{
			idc = 1000;
			text = "Can Spawn Platoon Vehicle's?"; //--- ToDo: Localize;
			x = 0.461628 * safezoneW + safezoneX;
			y = 0.313 * safezoneH + safezoneY;
			w = 0.0844186 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class PlatoonYesButton: RscButton
		{
			idc = 1600;
			action = "D207_CanSpawnCode = 1; D207_CanSpawnBool = 1; execVM '207Scripts\Vehiclespawner\CanSpawnCode.sqf';";
			text = "Yes"; //--- ToDo: Localize;
			x = 0.469302 * safezoneW + safezoneX;
			y = 0.346 * safezoneH + safezoneY;
			w = 0.0306977 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class PlatoonNoButton: RscButton
		{
			idc = 1601;
			action = "D207_CanSpawnCode = 1; D207_CanSpawnBool = 2; execVM '207Scripts\Vehiclespawner\CanSpawnCode.sqf';";
			text = "No"; //--- ToDo: Localize;
			x = 0.507674 * safezoneW + safezoneX;
			y = 0.346 * safezoneH + safezoneY;
			w = 0.0306977 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class FoxtrotVehicleText: RscText
		{
			idc = 1001;
			text = "Can Spawn Foxtrot Vehicle's?"; //--- ToDo: Localize;
			x = 0.461628 * safezoneW + safezoneX;
			y = 0.379 * safezoneH + safezoneY;
			w = 0.0844186 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class FoxtrotYesButton: RscButton
		{
			idc = 1602;
			action = "D207_CanSpawnCode = 2; D207_CanSpawnBool = 1; execVM '207Scripts\Vehiclespawner\CanSpawnCode.sqf';";
			text = "Yes"; //--- ToDo: Localize;
			x = 0.469302 * safezoneW + safezoneX;
			y = 0.412 * safezoneH + safezoneY;
			w = 0.0306977 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class FoxtrotNoButton: RscButton
		{
			idc = 1603;
			action = "D207_CanSpawnCode = 2; D207_CanSpawnBool = 2; execVM '207Scripts\Vehiclespawner\CanSpawnCode.sqf';";
			text = "No"; //--- ToDo: Localize;
			x = 0.507674 * safezoneW + safezoneX;
			y = 0.412 * safezoneH + safezoneY;
			w = 0.0306977 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class HawkeyeVehicleText: RscText
		{
			idc = 1002;
			text = "Can Spawn Hawkeye Vehicle's?"; //--- ToDo: Localize;
			x = 0.461628 * safezoneW + safezoneX;
			y = 0.445 * safezoneH + safezoneY;
			w = 0.0882558 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class HawkeyeYesButton: RscButton
		{
			idc = 1604;
			action = "D207_CanSpawnCode = 3; D207_CanSpawnBool = 1; execVM '207Scripts\Vehiclespawner\CanSpawnCode.sqf';";
			text = "Yes"; //--- ToDo: Localize;
			x = 0.469302 * safezoneW + safezoneX;
			y = 0.478 * safezoneH + safezoneY;
			w = 0.0306977 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class HawkeyeNoButton: RscButton
		{
			idc = 1605;
			action = "D207_CanSpawnCode = 3; D207_CanSpawnBool = 2; execVM '207Scripts\Vehiclespawner\CanSpawnCode.sqf';";
			text = "No"; //--- ToDo: Localize;
			x = 0.507674 * safezoneW + safezoneX;
			y = 0.478 * safezoneH + safezoneY;
			w = 0.0306977 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class DroneVehicleText: RscText
		{
			idc = 1003;
			text = "Can Spawn Drone's?"; //--- ToDo: Localize;
			x = 0.47314 * safezoneW + safezoneX;
			y = 0.511 * safezoneH + safezoneY;
			w = 0.0613954 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class DroneYesButton: RscButton
		{
			idc = 1606;
			action = "D207_CanSpawnCode = 4; D207_CanSpawnBool = 1; execVM '207Scripts\Vehiclespawner\CanSpawnCode.sqf';";
			text = "Yes"; //--- ToDo: Localize;
			x = 0.469302 * safezoneW + safezoneX;
			y = 0.544 * safezoneH + safezoneY;
			w = 0.0306977 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class DroneNoButton: RscButton
		{
			idc = 1607;
			action = "D207_CanSpawnCode = 4; D207_CanSpawnBool = 2; execVM '207Scripts\Vehiclespawner\CanSpawnCode.sqf';";
			text = "No"; //--- ToDo: Localize;
			x = 0.507674 * safezoneW + safezoneX;
			y = 0.544 * safezoneH + safezoneY;
			w = 0.0306977 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class ButtonCancel: RscButton
		{
			idc = 1608;
			action = "closeDialog 2;";
			text = "Cancel";
			x = 0.476976 * safezoneW + safezoneX;
			y = 0.577 * safezoneH + safezoneY;
			w = 0.0537209 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class AllNo: RscButton
		{
			idc = 1609;
			action = "D207_CanSpawnCode = 5; D207_CanSpawnBool = 1; execVM '207Scripts\Vehiclespawner\CanSpawnCode.sqf';";
			text = "All No"; //--- ToDo: Localize;
			x = 0.507674 * safezoneW + safezoneX;
			y = 0.61 * safezoneH + safezoneY;
			w = 0.0306977 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class AllYes: RscButton
		{
			idc = 1610;
			action = "D207_CanSpawnCode = 5; D207_CanSpawnBool = 2; execVM '207Scripts\Vehiclespawner\CanSpawnCode.sqf';";
			text = "All Yes"; //--- ToDo: Localize;
			x = 0.469302 * safezoneW + safezoneX;
			y = 0.61 * safezoneH + safezoneY;
			w = 0.0306977 * safezoneW;
			h = 0.022 * safezoneH;
		};
	};
};
class CheckScripts
{
	idd = 8300;
	
	class controls
	{
		class BackFrame: RscFrame
		{
			idc = 1800;
			x = 0.423256 * safezoneW + safezoneX;
			y = 0.291 * safezoneH + safezoneY;
			w = 0.153488 * safezoneW;
			h = 0.176 * safezoneH;
		};
		class Edit1: RscEdit
		{
			idc = 1401;
			x = 0.507674 * safezoneW + safezoneX;
			y = 0.313 * safezoneH + safezoneY;
			w = 0.0613954 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class Edit2: RscEdit
		{
			idc = 1402;
			x = 0.507674 * safezoneW + safezoneX;
			y = 0.357 * safezoneH + safezoneY;
			w = 0.0613954 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class Edit3: RscEdit
		{
			idc = 1403;
			x = 0.507674 * safezoneW + safezoneX;
			y = 0.401 * safezoneH + safezoneY;
			w = 0.0613954 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class Text1: RscText
		{
			idc = 1001;
			text = "Init Should Be";
			x = 0.43093 * safezoneW + safezoneX;
			y = 0.313 * safezoneH + safezoneY;
			w = 0.0613954 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class Text2: RscText
		{
			idc = 1002;
			text = "Main Should Be";
			x = 0.43093 * safezoneW + safezoneX;
			y = 0.357 * safezoneH + safezoneY;
			w = 0.0613954 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class Text3: RscText
		{
			idc = 1003;
			text = "Config Should Be";
			x = 0.43093 * safezoneW + safezoneX;
			y = 0.401 * safezoneH + safezoneY;
			w = 0.0613954 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class CheckButton: RscButton
		{
			idc = 1600;
			action = "execVM '207Scripts\Vehiclespawner\CheckScripts.sqf';";
			text = "Check";
			x = 0.469302 * safezoneW + safezoneX;
			y = 0.434 * safezoneH + safezoneY;
			w = 0.0613954 * safezoneW;
			h = 0.022 * safezoneH;
		};
	};
};