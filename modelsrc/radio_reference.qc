// Created by Crowbar 0.74

$ModelName "props/radio_reference.mdl"

$BodyGroup "Body"
{
	studio "radio_rtx.smd"
}


$SurfaceProp "metalpanel"

$Contents "solid"

$IllumPosition 0 0 15.422

$CDMaterials "models\rtx/props\radio_reference\"

$CBox 0 0 0 0 0 0

$BBox -4.899 -12.46 -0.284 4.899 12.459 31.23

$DefineBone "polymsh" "" 0 0 0 0 0 89.999982 0 0 0 0 0 0


$Sequence "idle" {
	"radio_reference_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$CollisionModel "radio_reference_physics.smd"
{
	$mass 30
	$inertia 1
	$damping 0
	$rotdamping 0
	$rootbone " "
	$concave
	$maxconvexpieces 4

}
