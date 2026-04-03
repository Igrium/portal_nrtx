// Created by Crowbar 0.74

$ModelName "props/bed_body_reference.mdl"

$BodyGroup "Body"
{
	studio "bed_body_reference_rtx.smd"
}


$SurfaceProp "metalpanel"

$Contents "solid"

$IllumPosition 2.945 0 31

$CDMaterials "models\props\bed_body_reference"

$CBox 0 0 0 0 0 0

$BBox -27.389 -58.846 -0.245 27.389 64.736 62.251

$DefineBone "root" "" 0 0 0 0 0 89.999982 0 0 0 0 0 0


$Sequence "idle" {
	"bed_body_reference_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$CollisionModel "bed_body_reference_physics.smd"
{
	$mass 120
	$inertia 1
	$damping 0
	$rotdamping 0
	$rootbone " "
	$concave
	$maxconvexpieces 16

}
