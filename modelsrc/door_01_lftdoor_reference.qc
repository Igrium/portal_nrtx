// Created by Crowbar 0.74

$ModelName "rtx/props/Door_01_lftDoor_reference.mdl"

$BodyGroup "Body"
{
	studio "Door_01_lftDoor.smd"
}
$texturegroup skinfamilies
{
	{ "door_01" }
	{ "door_01_off" }
	{ "door_01_red" }
	{ "door_01_orange" }
}
//skins out of order for parity with Portal 2's props/portaldoor.mdl

//$LOD 40
//{
//	replacemodel "Door_01_lftDoor_reference.smd" "Door_01_lftDoor_reference_lod1.smd"
//	NoFacial
//}

$SurfaceProp "metal"

$Contents "solid"

$IllumPosition 28.427 0.017 50.574

$CDMaterials "models\rtx/props\door_01\"

$CBox 0 0 0 0 0 0

$BBox -7.224 0 -0.003 7.19 56.853 101.15

$DefineBone "polymsh" "" 0 0 0 0 0 89.999982 0 0 0 0 0 0


$Sequence "idle" {
	"door_01_lftdoor_reference_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}
