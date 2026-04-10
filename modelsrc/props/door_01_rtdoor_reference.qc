// Created by Crowbar 0.74

$ModelName "props/Door_01_rtDoor_reference.mdl"

$BodyGroup "Body"
{
	studio "Door_01_rtDoor.smd"
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
//	replacemodel "Door_01_rtDoor_reference.smd" "Door_01_rtDoor_reference_lod1.smd"
//	NoFacial
//}

$SurfaceProp "metal"

$Contents "solid"

$IllumPosition -28.427 0.017 50.575

$CDMaterials "models\props\door_01\"

$CBox 0 0 0 0 0 0

$BBox -7.223 -56.853 0 7.19 0 101.15

$DefineBone "polymsh" "" 0 0 0 0 0 89.999982 0 0 0 0 0 0


$Sequence "idle" {
	"door_01_rtdoor_reference_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}
