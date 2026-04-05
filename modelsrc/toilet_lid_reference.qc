// Created by Crowbar 0.74

$ModelName "rtx/props/toilet_lid_reference.mdl"

$BodyGroup "Body"
{
	studio "toilet_lid.smd"
}

$staticprop

$SurfaceProp "metalpanel"

$Contents "solid"

$IllumPosition 0 -4.578 26.365

$CDMaterials "models\props\toilet_reference"

$CBox 0 0 0 0 0 0

$BBox 0 -10.717 0 9.361 10.717 52.868

//$DefineBone "static_prop" "" 0 0 0 0 0 89.999982 0 0 0 0 0 0


$Sequence "idle" {
	"toilet_lid_reference_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$CollisionModel "toilet_lid_reference_physics.smd"
{
	$mass 120
	$inertia 1
	$damping 0
	$rotdamping 0
	$rootbone " "
	$concave
	$maxconvexpieces 6

}
