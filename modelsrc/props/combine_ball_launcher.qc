// Created by Crowbar 0.74

$ModelName "props/combine_ball_launcher.mdl"

$BodyGroup "Body"
{
	studio "ball_launcher.smd"
}

//$LOD 20
//{
//	replacemodel "combine_ball_launcher_reference.smd" "combine_ball_launcher_reference_lod1.smd"
//	NoFacial
//}
//$LOD 30
//{
//	replacemodel "combine_ball_launcher_reference.smd" "combine_ball_launcher_reference_lod2.smd"
//	NoFacial
//}
//$LOD 55
//{
//	replacemodel "combine_ball_launcher_reference.smd" "combine_ball_launcher_reference_lod3.smd"
//	NoFacial
//}

$SurfaceProp "metalpanel"

$Contents "solid"

$IllumPosition 0 -21.324 1.782

$CDMaterials "models\props\combine_ball"

$texturegroup skinfamilies
{
	{ "launcher" }
	{ "launcher_orange" }
	{ "launcher_red" }
	{ "launcher_off" }
}


$CBox 0 0 0 0 0 0

$BBox -0.438 -50 -50 43.087 50 53.564

$DefineBone "Root" "" 0 0 0 0 0 89.999982 0 0 0 0 0 0
$DefineBone "Arm1_1" "Root" 0.000417 38.762794 1.967424 0 0 0 0 0 0 0 0 0
$DefineBone "Arm1_2" "Arm1_1" 0.004898 7.538363 28.306084 0 0 0 0 0 0 0 0 0
$DefineBone "Arm1_3" "Arm1_2" 0.009832 -39.547501 11.188068 0 0 0 0 0 0 0 0 0
$DefineBone "Arm2_1" "Root" 31.338125 -22.756083 1.927585 0 -36.499988 0 0 0 0 0 0 0
$DefineBone "Arm2_2" "Arm2_1" 7.216468 0.023948 28.257505 0 0 0 0 0 0 0 0 0
$DefineBone "Arm2_3" "Arm2_2" -39.555176 -0.245986 11.175534 0 0 0 0 0 0 0 0 0
$DefineBone "Arm3_1" "Root" -31.665152 -23.048283 1.924886 0 -53.499991 0 0 0 0 0 0 0
$DefineBone "Arm3_2" "Arm3_1" -0.026383 -7.456958 28.391714 0 0 0 0 0 0 0 0 0
$DefineBone "Arm3_3" "Arm3_2" 0.259516 39.546661 11.177461 0 0 0 0 0 0 0 0 0
$DefineBone "Sphere1" "Root" 0 50 0 0 0 0 0 0 0 0 0 0
$DefineBone "Sphere2" "Root" 50 -50 0 0 -36.499988 0 0 0 0 0 0 0
$DefineBone "Sphere3" "Root" -50 -50 0 0 -53.499991 0 0 0 0 0 0 0


$Sequence "idle_closed" {
	"combine_ball_launcher_anims\idle_closed.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$Sequence "idle_open" {
	"combine_ball_launcher_anims\idle_open.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$Sequence "open" {
	"combine_ball_launcher_anims\open.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$Sequence "close" {
	"combine_ball_launcher_anims\close.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$CollisionModel "combine_ball_launcher_physics.smd"
{
	$mass 120
	$inertia 1
	$damping 0
	$rotdamping 0
	$rootbone " "
	$concave
	$maxconvexpieces 11

}
