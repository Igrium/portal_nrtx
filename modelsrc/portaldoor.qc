// Created by Crowbar 0.74

$ModelName "rtx/props\portaldoor.mdl"

$BodyGroup "Body"
{
	studio "portaldoor_rtx.smd"
}


$SurfaceProp "metal"

$Contents "solid"

$IllumPosition 0 -8.461 54.118

$CDMaterials "models\rtx/props\door_01\"
//$CDMaterials ""

//$TextureGroup "skinfamilies"
//{
//	{ "Door_01"     }
//	{ "Door_01_off" }
//}
$texturegroup skinfamilies
{
	{ "door_01" }
	{ "door_01_off" }
	{ "door_01_red" }
	{ "door_01_orange" }
}
//skins out of order for parity with Portal 2's props/portaldoor.mdl
$CBox 0 0 0 0 0 0

$BBox 0 -63.86 -0.003 16.921 63.861 108.24

$DefineBone "door_root" "" 0 0 0 0 0 0 0 0 0 0 0 0
$DefineBone "door_left" "door_root" -10 0 0 0 0 0 0 0 0 0 0 0
$DefineBone "door_right" "door_root" 10 0 0 0 0 0 0 0 0 0 0 0


$Sequence "idleclosed" {
	"portaldoor_anims\idleclosed.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$Sequence "idleopen" {
	"portaldoor_anims\idleopen.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$Sequence "open" {
	"portaldoor_anims\open.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$Sequence "close" {
	"portaldoor_anims\close.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$CollisionJoints "portaldoor_physics.smd"
{
	$mass 50
	$inertia 1
	$damping 0
	$rotdamping 0
	$rootbone " "
	$concave
	$maxconvexpieces 10
	$concaveperjoint


	$jointconstrain "door_left" x limit 0 0 0
	$jointconstrain "door_left" y limit 0 0 0
	$jointconstrain "door_left" z limit 0 0 0

	$jointconstrain "door_right" x limit 0 0 0
	$jointconstrain "door_right" y limit 0 0 0
	$jointconstrain "door_right" z limit 0 0 0
}

$KeyValues
{
	bone_followers 
	{
		"bone" "door_root"
		"bone" "door_left"
		"bone" "door_right"
	}
}
