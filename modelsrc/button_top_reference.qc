// Created by Crowbar 0.74

$ModelName "rtx/props/button_top_reference.mdl"

$BodyGroup "Body"
{
	studio "pad.smd"
}
$MostlyOpaque
//$LOD 25
//{
//	replacemodel "button_top_reference.smd" "button_top_reference_lod1.smd"
//	NoFacial
//}
$texturegroup skinfamilies
{
	{ "button_top"       "button_top_center" }
	{ "button_top_glass" "button_top_raw"    }
}
$SurfaceProp "metal"

$Contents "solid"

$IllumPosition -0.005 0.03 6.82

$CDMaterials "models\rtx/props\button_reference\"

$CBox 0 0 0 0 0 0

$BBox -34.356 -34.331 0 34.296 34.321 13.896

$DefineBone "button_whole_reference_02.polymsh" "" 0 0 0 0 0 89.999982 0 0 0 0 0 0


$Sequence "idle" {
	"button_top_reference_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$CollisionModel "button_top_reference_physics.smd"
{
	$mass 120
	$inertia 1
	$damping 0
	$rotdamping 0
	$rootbone " "
	$concave
	$maxconvexpieces 1

}
