class VehicleSpawnerStart
{
	idd = 8000;
	
	class controls
	{
		class baseFrame: IGUIBack
		{
			idc = 2200;

			x = 0.438605 * safezoneW + safezoneX;
			y = 0.39 * safezoneH + safezoneY;
			w = 0.107442 * safezoneW;
			h = 0.198 * safezoneH;
			colorBackground[] = {0,0,0,0.5};
		};
		class ButtonPlatoonVehicle: RscButton
		{
			idc = 1601;
			action = "D207_VehicleSpawnerType = 1; execVM '207Scripts\Vehiclespawner\OpenDialog.sqf';";

			text = "Platoon"; //--- ToDo: Localize;
			x = 0.442442 * safezoneW + safezoneX;
			y = 0.456 * safezoneH + safezoneY;
			w = 0.0460465 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class ButtonFoxtrotVehicle: RscButton
		{
			idc = 1602;
			action = "D207_VehicleSpawnerType = 2; execVM '207Scripts\Vehiclespawner\OpenDialog.sqf';";

			text = "Foxtrot"; //--- ToDo: Localize;
			x = 0.496163 * safezoneW + safezoneX;
			y = 0.456 * safezoneH + safezoneY;
			w = 0.0460465 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class ButtonHawkeyeVehicle: RscButton
		{
			idc = 1603;
			action = "D207_VehicleSpawnerType = 3; execVM '207Scripts\Vehiclespawner\OpenDialog.sqf';";

			text = "Hawkeye"; //--- ToDo: Localize;
			x = 0.442442 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.0460465 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class ButtonDrone: RscButton
		{
			idc = 1604;
			action = "D207_VehicleSpawnerType = 4; execVM '207Scripts\Vehiclespawner\OpenDialog.sqf';";

			text = "Drone"; //--- ToDo: Localize;
			x = 0.496163 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.0460465 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class ButtonCanSpawn: RscButton
		{
			idc = 1605;
			action = "execVM '207Scripts\Vehiclespawner\canSpawn.sqf';";
			text = "Spawnable"; //--- ToDo: Localize;
			x = 0.496163 * safezoneW + safezoneX;
			y = 0.401 * safezoneH + safezoneY;
			w = 0.0460465 * safezoneW;
			h = 0.044 * safezoneH;
			colorBackground[] = {0,0,0,1};
			colorActive[] = {0,0,0,1};
		};
		class ButtonCheckSpawn: RscButton
		{
			idc = 1606;
			action = "execVM '207Scripts\Vehiclespawner\CheckSpawn.sqf';";

			text = "Check Spawn"; //--- ToDo: Localize;
			x = 0.442442 * safezoneW + safezoneX;
			y = 0.401 * safezoneH + safezoneY;
			w = 0.0460465 * safezoneW;
			h = 0.044 * safezoneH;
			colorBackground[] = {0,0,0,1};
			colorActive[] = {0,0,0,1};
		};
		class ButtonCancel: RscButton
		{
			idc = 1607;
			action = "closeDialog 2;";

			text = "Cancel"; //--- ToDo: Localize;
			x = 0.496163 * safezoneW + safezoneX;
			y = 0.544 * safezoneH + safezoneY;
			w = 0.0460465 * safezoneW;
			h = 0.033 * safezoneH;
			colorBackground[] = {0,0,0,1};
			colorActive[] = {0,0,0,1};
		};
		class EditVehicle: RscButton
		{
			idc = 1607;
			action = "execVM '207Scripts\Vehiclespawner\EditVehicle.sqf';";
			text = "Edit Vehicle"; //--- ToDo: Localize;
			x = 0.442442 * safezoneW + safezoneX;
			y = 0.544 * safezoneH + safezoneY;
			w = 0.0460465 * safezoneW;
			h = 0.033 * safezoneH;
			colorBackground[] = {0,0,0,1};
			colorActive[] = {0,0,0,1};
		};
	};
};

class VehicleSpawner
{
	idd = 8100;
	
	class controls
	{
		class baseFrame: IGUIBack
		{
			idc = 2200;

			x = 9 * GUI_GRID_W + GUI_GRID_X;
			y = 7 * GUI_GRID_H + GUI_GRID_Y;
			w = 22 * GUI_GRID_W;
			h = 12 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0.5};
		};
		class ButtonSpawn: RscButton
		{
			idc = 1600;
			action = "execVM '207Scripts\Vehiclespawner\Spawn.sqf';";
			text = "Spawn"; //--- ToDo: Localize;
			x = 9.5 * GUI_GRID_W + GUI_GRID_X;
			y = 15 * GUI_GRID_H + GUI_GRID_Y;
			w = 4.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class ButtonBack: RscButton
		{
			idc = 1601;
			action = "execVM '207Scripts\Vehiclespawner\StartDialog.sqf';closeDialog 2;";
			text = "Back"; //--- ToDo: Localize;
			x = 26 * GUI_GRID_W + GUI_GRID_X;
			y = 15 * GUI_GRID_H + GUI_GRID_Y;
			w = 4 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class CheckSpawn: RscButton
		{
			idc = 1602;
			action = "execVM '207Scripts\Vehiclespawner\CheckSpawn.sqf';";
			text = "Check Spawn"; //--- ToDo: Localize;
			x = 14.5 * GUI_GRID_W + GUI_GRID_X;
			y = 15 * GUI_GRID_H + GUI_GRID_Y;
			w = 5.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class BoxList: RscListBox
		{
			idc = 1500;
			x = 9.5 * GUI_GRID_W + GUI_GRID_X;
			y = 7.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 21 * GUI_GRID_W;
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
		class VehicleEditor: RscCheckBox
		{
			idc = 2800;
			x = 10 * GUI_GRID_W + GUI_GRID_X;
			y = 17 * GUI_GRID_H + GUI_GRID_Y;
			w = 1.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class VehicleEditorTXT: RscText
		{
			idc = 1001;
			text = "Open Vehicle Editor On Spawn"; //--- ToDo: Localize;
			x = 12 * GUI_GRID_W + GUI_GRID_X;
			y = 17 * GUI_GRID_H + GUI_GRID_Y;
			w = 11.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class Spawnable: RscButton
		{
			idc = 1601;
			action = "execVM '207Scripts\Vehiclespawner\canSpawn.sqf';";
			text = "Spawnable?"; //--- ToDo: Localize;
			x = 20.5 * GUI_GRID_W + GUI_GRID_X;
			y = 15 * GUI_GRID_H + GUI_GRID_Y;
			w = 5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class ButtonCancel: RscButton
		{
			idc = 1601;
			action = "closeDialog 2;";
			text = "Cancel"; //--- ToDo: Localize;
			x = 26 * GUI_GRID_W + GUI_GRID_X;
			y = 17 * GUI_GRID_H + GUI_GRID_Y;
			w = 4 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
	};
};

class CanSpawnVehicle
{
	idd = 8200;
	
	class controls
	{
		class RscFrame: IGUIBack
		{
			idc = 2200;
			x = 13 * GUI_GRID_W + GUI_GRID_X;
			y = 2.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 14 * GUI_GRID_W;
			h = 20 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0.5};
		};
		class PlatoonVehicleText: RscText
		{
			idc = 1000;
			text = "Platoon"; //--- ToDo: Localize;
			x = 14.5 * GUI_GRID_W + GUI_GRID_X;
			y = 3 * GUI_GRID_H + GUI_GRID_Y;
			w = 3.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class PlatoonYesButton: RscButton
		{
			idc = 1600;
			action = "D207_Platoon = 1; execVM '207Scripts\Vehiclespawner\CanSpawnCode.sqf';";
			text = "Yes"; //--- ToDo: Localize;
			x = 13.5 * GUI_GRID_W + GUI_GRID_X;
			y = 6 * GUI_GRID_H + GUI_GRID_Y;
			w = 2.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class PlatoonNoButton: RscButton
		{
			idc = 1601;
			action = "D207_Platoon = 2; execVM '207Scripts\Vehiclespawner\CanSpawnCode.sqf';";
			text = "No"; //--- ToDo: Localize;
			x = 16.5 * GUI_GRID_W + GUI_GRID_X;
			y = 6 * GUI_GRID_H + GUI_GRID_Y;
			w = 2.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class FoxtrotVehicleText: RscText
		{
			idc = 1001;
			text = "Foxtrot"; //--- ToDo: Localize;
			x = 22 * GUI_GRID_W + GUI_GRID_X;
			y = 3 * GUI_GRID_H + GUI_GRID_Y;
			w = 3.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class FoxtrotYesButton: RscButton
		{
			idc = 1602;
			action = "D207_Foxtrot = 1;execVM '207Scripts\Vehiclespawner\CanSpawnCode.sqf';";
			text = "Yes"; //--- ToDo: Localize;
			x = 21 * GUI_GRID_W + GUI_GRID_X;
			y = 6 * GUI_GRID_H + GUI_GRID_Y;
			w = 2.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class FoxtrotNoButton: RscButton
		{
			idc = 1603;
			action = "D207_Foxtrot = 2;execVM '207Scripts\Vehiclespawner\CanSpawnCode.sqf';";
			text = "No"; //--- ToDo: Localize;
			x = 24 * GUI_GRID_W + GUI_GRID_X;
			y = 6 * GUI_GRID_H + GUI_GRID_Y;
			w = 2.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class HawkeyeVehicleText: RscText
		{
			idc = 1002;
			text = "Hawkeye"; //--- ToDo: Localize;
			x = 14.5 * GUI_GRID_W + GUI_GRID_X;
			y = 10.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 3.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class HawkeyeYesButton: RscButton
		{
			idc = 1604;
			action = "D207_Hawkeye = 1; execVM '207Scripts\Vehiclespawner\CanSpawnCode.sqf';";
			text = "Yes"; //--- ToDo: Localize;
			x = 13.5 * GUI_GRID_W + GUI_GRID_X;
			y = 13.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 2.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class HawkeyeNoButton: RscButton
		{
			idc = 1605;
			action = "D207_Hawkeye = 2; execVM '207Scripts\Vehiclespawner\CanSpawnCode.sqf';";
			text = "No"; //--- ToDo: Localize;
			x = 16.5 * GUI_GRID_W + GUI_GRID_X;
			y = 13.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 2.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class DroneVehicleText: RscText
		{
			idc = 1003;
			text = "Drone's"; //--- ToDo: Localize;
			x = 22 * GUI_GRID_W + GUI_GRID_X;
			y = 10.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 3.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class DroneYesButton: RscButton
		{
			idc = 1606;
			action = "D207_Drone = 1; execVM '207Scripts\Vehiclespawner\CanSpawnCode.sqf';";
			text = "Yes"; //--- ToDo: Localize;
			x = 21 * GUI_GRID_W + GUI_GRID_X;
			y = 13.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 2.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class DroneNoButton: RscButton
		{
			idc = 1607;
			action = "D207_Drone = 2; execVM '207Scripts\Vehiclespawner\CanSpawnCode.sqf';";
			text = "No"; //--- ToDo: Localize;
			x = 24 * GUI_GRID_W + GUI_GRID_X;
			y = 13.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 2.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class ButtonCancel: RscButton
		{
			idc = 1608;
			action = "closeDialog 2;";
			text = "Cancel"; //--- ToDo: Localize;
			x = 16.5 * GUI_GRID_W + GUI_GRID_X;
			y = 18 * GUI_GRID_H + GUI_GRID_Y;
			w = 7 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class AllYes: RscButton
		{
			idc = 1609;
			action = "D207_CanSpawnAll = 1; execVM '207Scripts\Vehiclespawner\CanSpawnCode.sqf';";
			text = "Yes"; //--- ToDo: Localize;
			x = 13.5 * GUI_GRID_W + GUI_GRID_X;
			y = 21 * GUI_GRID_H + GUI_GRID_Y;
			w = 2.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class AllNo: RscButton
		{
			idc = 1610;
			action = "D207_CanSpawnAll = 2; execVM '207Scripts\Vehiclespawner\CanSpawnCode.sqf';";
			text = "No"; //--- ToDo: Localize;
			x = 16.5 * GUI_GRID_W + GUI_GRID_X;
			y = 21 * GUI_GRID_H + GUI_GRID_Y;
			w = 2.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		
		class Platoonspawnable: RscText
		{
			idc = 1000;
			text = "spawnable?"; //--- ToDo: Localize;
			x = 14 * GUI_GRID_W + GUI_GRID_X;
			y = 4.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 4.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class PlatoonTickets: RscEdit
		{
			idc = 1400;
			x = 13.5 * GUI_GRID_W + GUI_GRID_X;
			y = 9 * GUI_GRID_H + GUI_GRID_Y;
			w = 2.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			maxChars = 3;
		};
		class PlatoonTicketsTXT: RscText
		{
			idc = 1000;
			text = "Tickets"; //--- ToDo: Localize;
			x = 14.5 * GUI_GRID_W + GUI_GRID_X;
			y = 7.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 3.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class PlatoonSetTickets: RscButton
		{
			idc = 1600;
			action = "D207_Tickets = 1; execVM '207Scripts\Vehiclespawner\CanSpawnCode.sqf';";
			text = "Set"; //--- ToDo: Localize;
			x = 16.5 * GUI_GRID_W + GUI_GRID_X;
			y = 9 * GUI_GRID_H + GUI_GRID_Y;
			w = 2.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class Hawkeyespawnable: RscText
		{
			idc = 1000;
			text = "spawnable?"; //--- ToDo: Localize;
			x = 14 * GUI_GRID_W + GUI_GRID_X;
			y = 12 * GUI_GRID_H + GUI_GRID_Y;
			w = 4.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class HawkeyeTicketsTXT: RscText
		{
			idc = 1000;
			text = "Tickets"; //--- ToDo: Localize;
			x = 14.5 * GUI_GRID_W + GUI_GRID_X;
			y = 15 * GUI_GRID_H + GUI_GRID_Y;
			w = 3.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class HawkeyeTickets: RscEdit
		{
			idc = 1401;
			x = 13.5 * GUI_GRID_W + GUI_GRID_X;
			y = 16.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 2.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			maxChars = 3;
		};
		class HawkeyeSetTickets: RscButton
		{
			idc = 1600;
			action = "D207_Tickets = 3; execVM '207Scripts\Vehiclespawner\CanSpawnCode.sqf';";
			text = "Set"; //--- ToDo: Localize;
			x = 16.5 * GUI_GRID_W + GUI_GRID_X;
			y = 16.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 2.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class AllSpawnable: RscText
		{
			idc = 1000;
			text = "All Spawnable"; //--- ToDo: Localize;
			x = 13.5 * GUI_GRID_W + GUI_GRID_X;
			y = 19.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 5.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class Foxtrotspawnable: RscText
		{
			idc = 1000;
			text = "spawnable?"; //--- ToDo: Localize;
			x = 21.5 * GUI_GRID_W + GUI_GRID_X;
			y = 4.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 4.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class FoxtrotTicketsTXT: RscText
		{
			idc = 1000;
			text = "Tickets"; //--- ToDo: Localize;
			x = 22 * GUI_GRID_W + GUI_GRID_X;
			y = 7.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 3.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class FoxtrotTickets: RscEdit
		{
			idc = 1402;
			x = 21 * GUI_GRID_W + GUI_GRID_X;
			y = 9 * GUI_GRID_H + GUI_GRID_Y;
			w = 2.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			maxChars = 3;
		};
		class FoxtrotSetTickets: RscButton
		{
			idc = 1600;
			action = "D207_Tickets = 2; execVM '207Scripts\Vehiclespawner\CanSpawnCode.sqf';";
			text = "Set"; //--- ToDo: Localize;
			x = 24 * GUI_GRID_W + GUI_GRID_X;
			y = 9 * GUI_GRID_H + GUI_GRID_Y;
			w = 2.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class Dronespawnable: RscText
		{
			idc = 1000;
			text = "spawnable?"; //--- ToDo: Localize;
			x = 21.5 * GUI_GRID_W + GUI_GRID_X;
			y = 12 * GUI_GRID_H + GUI_GRID_Y;
			w = 4.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class DroneTicketsTXT: RscText
		{
			idc = 1000;
			text = "Tickets"; //--- ToDo: Localize;
			x = 22 * GUI_GRID_W + GUI_GRID_X;
			y = 15 * GUI_GRID_H + GUI_GRID_Y;
			w = 3.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class DroneTickets: RscEdit
		{
			idc = 1403;
			x = 21 * GUI_GRID_W + GUI_GRID_X;
			y = 16.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 2.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			maxChars = 3;
		};
		class DroneSetTickets: RscButton
		{
			idc = 1600;
			action = "D207_Tickets = 4; execVM '207Scripts\Vehiclespawner\CanSpawnCode.sqf';";
			text = "Set"; //--- ToDo: Localize;
			x = 24 * GUI_GRID_W + GUI_GRID_X;
			y = 16.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 2.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class AllTicketsTXT: RscText
		{
			idc = 1000;
			text = "All Tickets"; //--- ToDo: Localize;
			x = 21.5 * GUI_GRID_W + GUI_GRID_X;
			y = 19.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 3.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class AllTickets: RscEdit
		{
			idc = 1404;
			x = 21 * GUI_GRID_W + GUI_GRID_X;
			y = 21 * GUI_GRID_H + GUI_GRID_Y;
			w = 2.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			maxChars = 3;
		};
		class AllSetTickets: RscButton
		{
			idc = 1600;
			action = "D207_Tickets = 5; execVM '207Scripts\Vehiclespawner\CanSpawnCode.sqf';";
			text = "Set"; //--- ToDo: Localize;
			x = 24 * GUI_GRID_W + GUI_GRID_X;
			y = 21 * GUI_GRID_H + GUI_GRID_Y;
			w = 2.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
	};
};
