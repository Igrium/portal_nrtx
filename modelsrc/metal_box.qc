// Created by Crowbar 0.74

$ModelName "props/metal_box.mdl"

$BodyGroup "Body"
{
	studio "cube.smd"
}

//$LOD 15
//{
//	replacemodel "metal_box_reference.smd" "metal_box_reference_lod1.smd"
//	NoFacial
//}
//$LOD 35
//{
//	replacemodel "metal_box_reference.smd" "metal_box_reference_lod2.smd"
//	NoFacial
//}
//$LOD 60
//{
//	replacemodel "metal_box_reference.smd" "metal_box_reference_lod3.smd"
//	NoFacial
//}
//$LOD 80
//{
//	replacemodel "metal_box_reference.smd" "metal_box_reference_lod4.smd"
//	NoFacial
//}

$SurfaceProp "metalpanel"

$Contents "solid"

$IllumPosition 0 0 -0.001

$CDMaterials "models\rtx\props\metal_box\"

//$TextureGroup "skinfamilies"
//{
//	{ "metal_box"         }
//	{ "metal_box_skin001" }
//}
$texturegroup skinfamilies
{
	{ "metal_box" }
	{ "metal_box_orange" }
	{ "metal_box_paint" }
	{ "metal_box_paint_orange" }
}
$CBox 0 0 0 0 0 0

$BBox -20.25 -20.25 -20.25 20.25 20.25 20.25

$DefineBone "polymsh" "" 0 0 0 0 0 89.999982 0 0 0 0 0 0


$Sequence "idle" {
	"metal_box_anims\idle.smd"
	activity "ACT_IDLE" 1
	fadein 0.2
	fadeout 0.2
	fps 30
}

$CollisionModel "metal_box_physics.smd"
{
	$mass 40
	$inertia 1
	$damping 0.1
	$rotdamping 0
	$rootbone " "
	$concave
	$maxconvexpieces 1

}

$KeyValues
{
	prop_data 
	{
		"base" "Metal.small"
	}
}
