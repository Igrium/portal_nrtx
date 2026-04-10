// Created by Crowbar 0.74

$ModelName "props/combine_ball_catcher.mdl"

$BodyGroup "Body"
{
	studio "ball_catcher.smd"
}

//$LOD 20
//{
//	replacemodel "combine_ball_catcher_reference.smd" "combine_ball_catcher_reference_lod1.smd"
//	NoFacial
//}
//$LOD 35
//{
//	replacemodel "combine_ball_catcher_reference.smd" "combine_ball_catcher_reference_lod2.smd"
//	NoFacial
//}
//$LOD 50
//{
//	replacemodel "combine_ball_catcher_reference.smd" "combine_ball_catcher_reference_lod3.smd"
//	NoFacial
//}

$SurfaceProp "combine_metal"

$Contents "solid"

$IllumPosition -0.095 -13.686 8.227

$CDMaterials "models\props\combine_ball"

$texturegroup skinfamilies
{
	{ "catcher" }
	{ "catcher_orange" }
	{ "catcher_red" }
	{ "catcher_off" }
}

$Attachment "ball_attachment" "base" 0 8 0 rotate 0 90 0

$CBox 0 0 0 0 0 0

$BBox -22.568 -45.235 -37.111 49.941 45.044 53.564

$DefineBone "Root" "" 0 0 0 0 0 179.999978 0 0 0 0 0 0
$DefineBone "base" "Root" 0 -1.192854 0 0 0 0 0 0 0 0 0 0
$DefineBone "Arm1_1" "Root" -0.007516 1.661901 -38.678123 0 0 0 0 0 0 0 0 0
$DefineBone "Arm1_2" "Arm1_1" 0.043808 26.968464 -8.657843 0 0 0 0 0 0 0 0 0
$DefineBone "Arm1_3" "Arm1_2" -0.117322 -0.978317 22.882669 0 0 0 0 0 0 0 0 0
$DefineBone "Arm2_1" "Root" 30.84259 0.853681 22.51721 -36.414962 0 0 0 0 0 0 0 0
$DefineBone "Arm2_2" "Arm2_1" 9.102726 27.610012 -0.241378 1.287264 -0.000115 0.000115 0 0 0 0 0 0
$DefineBone "Arm2_3" "Arm2_2" -22.929998 -0.812461 -0.269203 0 0 0 0 0 0 0 0 0
$DefineBone "Arm3_1" "Root" -31.46871 0.984949 22.721989 36.414904 0 0 0 0 0 0 0 0
$DefineBone "Arm3_2" "Arm3_1" -8.49877 27.590731 -0.161533 0 0 0 0 0 0 0 0 0
$DefineBone "Arm3_3" "Arm3_2" 22.815048 -0.923894 0.316671 0 0 0 0 0 0 0 0 0
$DefineBone "Cover1" "Root" -0.797711 -21.250099 23.5 0 0 0 0 0 0 0 0 0
$DefineBone "Cover2" "Root" -22.322725 -21.250099 -9.652626 65.127998 0 0 0 0 0 0 0 0
$DefineBone "Cover3" "Root" 20.304663 -21.250099 -10.614347 -63.491171 0 0 0 0 0 0 0 0
$DefineBone "Spinner_casing" "Root" 0 10.519909 0 0 0 0 0 0 0 0 0 0
$DefineBone "Spinners" "Spinner_casing" 0 2.11414 0 0 0 0 0 0 0 0 0 0


$Sequence "idle" {
	"combine_ball_catcher_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$Sequence "closed" {
	"combine_ball_catcher_anims\closed.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$Sequence "close" {
	"combine_ball_catcher_anims\close.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}
