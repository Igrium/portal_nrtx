// Created by Crowbar 0.74

$ModelName "rtx/props_bts/bts_stool_static.mdl"

$StaticProp

$BodyGroup "Body"
{
	studio "bts_stool.smd"
}

$LOD 4
{
	replacemodel "bts_stool.smd" "bts_stool_lod1.smd"
	NoFacial
}

//$LOD 30
//{
//	replacemodel "bts_stool_reference.smd" "bts_stool_reference_lod1.smd"
//	NoFacial
//}
//$LOD 80
//{
//	replacemodel "bts_stool_reference.smd" "bts_stool_reference_lod2.smd"
//	NoFacial
//}

$SurfaceProp "metal"

$Contents "solid"

$IllumPosition 0 0 17.974

$CDMaterials "models\rtx\props_bts\bts_stool"

$CBox 0 0 0 0 0 0

$BBox -11.445 -10.784 0 11.068 10.658 36.095

$DefineBone "static_prop" "" 0 0 0 0 0 0 0 0 0 0 0 0


$Sequence "idle" {
	"bts_stool_static_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$CollisionModel "bts_stool_static_physics.smd"
{
	$mass 50
	$inertia 1
	$damping 0
	$rotdamping 0
	$rootbone " "
	$concave
	$maxconvexpieces 8

}
