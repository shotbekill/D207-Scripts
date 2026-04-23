_box = "Box_IDAP_Uniforms_F" createVehicle position player;
clearItemCargoGlobal _box;
clearMagazineCargoGlobal _box;
clearBackpackCargoGlobal _box;
clearWeaponCargoGlobal _box;

_box addItemCargoGlobal ["kat_sealant", 20];
_box addItemCargoGlobal ["G_AirPurifyingRespirator_01_F", 20];
_box addItemCargoGlobal ["kat_gasmaskFilter", 50];
_box addItemCargoGlobal ["ChemicalDetector_01_watch_F", 20];
_box addItemCargoGlobal ["kat_mask_M04", 20];

systemChat "An CBRN full Gear crate was spawned near you.";