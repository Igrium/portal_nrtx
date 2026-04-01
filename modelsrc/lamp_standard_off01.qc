// Created by Crowbar 0.74

$ModelName "props_c17/lamp_standard_off01.mdl"

$StaticProp

$BodyGroup "Body"
{
	studio "lamp_standard_rtx01.smd"
}
$texturegroup skinfamilies
{
	{ "lamp_standard01" }
	{ "lamp_standard01_off" }
}
//$LOD 15
//{
//	replacemodel "lamp_standard_off01_reference.smd" "lamp_standard_off01_reference_lod1.smd"
//	NoFacial
//}
//$LOD 30
//{
//	replacemodel "lamp_standard_off01_reference.smd" "lamp_standard_off01_reference_lod2.smd"
//	NoFacial
//}
//$LOD 40
//{
//	replacemodel "lamp_standard_off01_reference.smd" "lamp_standard_off01_reference_lod3.smd"
//	NoFacial
//}

$SurfaceProp "metal"

$Contents "solid"

$IllumPosition 0 0 6.283

$CDMaterials "models\rtx/props_c17\"

$CBox 0 0 0 0 0 0

$BBox -12.149 -12.149 0 12.148 12.148 12.566

$DefineBone "static_prop" "" 0 0 0 0 0 0 0 0 0 0 0 0


$Sequence "idle" {
	"lamp_standard_off01_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$CollisionModel "lamp_standard_off01_physics.smd"
{
	$mass 4.645161
	$inertia 1
	$damping 0
	$rotdamping 0
	$rootbone " "
	$concave
	$maxconvexpieces 3

}

$KeyValues
{
	prop_data 
	{
		"base" "Metal.Small"
	}
}
