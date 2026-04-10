// Created by Crowbar 0.74

$ModelName "rtx\props\elevator_caps\elevator_caps.mdl"

$StaticProp

$BodyGroup "elevator_caps"
{
	studio "elevator_caps.smd"
}

//$LOD 100
//{
//	replacemodel "elevator_caps_reference.smd" "elevator_caps_reference_lod1.smd"
//	NoFacial
//}

$SurfaceProp "metal"

$Contents "solid"

$IllumPosition 0 131.153 -4.835

$CDMaterials "models\rtx\props\elevator_caps\"

$CBox 0 0 0 0 0 0

$BBox -275.822 -132.55 -105.826 11.122 132.55 96.94

$DefineBone "static_prop" "" 0 0 0 0 0 0 0 0 0 0 0 0


$Sequence "idle" {
	"elevator_caps_anims\idle.smd"
	activity "ACT_IDLE" 1
	fadein 0.2
	fadeout 0.2
	fps 30
}

$CollisionModel "elevator_caps_physics.smd"
{
	$mass 1
	$inertia 1
	$damping 0
	$rotdamping 0
	$rootbone " "
	//$concaveperjoint
	$concave
	//$maxconvexpieces 19

}
