// Created by Crowbar 0.74

$ModelName "props_bts/bts_chair_static.mdl"

$StaticProp

$BodyGroup "Body"
{
	studio "bts_chair.smd"
}
$LOD 10
{
	replacemodel "bts_chair.smd" "bts_chair_lod1.smd"
}

$SurfaceProp "metal"

$Contents "solid"

$IllumPosition 0 0 0

$CDMaterials "models\props_bts\bts_chair"

$CBox 0 0 0 0 0 0

$BBox -9.586 -9.634 -19.525 9.836 9.634 19.472

$DefineBone "static_prop" "" 0 0 0 0 0 0 0 0 0 0 0 0


$Sequence "idle" {
	"bts_chair_static_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$CollisionModel "bts_chair_static_physics.smd"
{
	$mass 50
	$inertia 1
	$damping 0
	$rotdamping 0
	$rootbone " "
	$concave
	$maxconvexpieces 8

}
