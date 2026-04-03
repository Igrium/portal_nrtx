// Created by Crowbar 0.74

$ModelName "props\autoportal_frame\autoportal_frame.mdl"

$StaticProp

$BodyGroup "autoportal_frame"
{
	studio "portal_frame_rtx.smd"
}


$SurfaceProp "metal"

$Contents "solid"

$IllumPosition 0 6.074 0

$CDMaterials "models\props\autoportal_frame\"

$CBox 0 0 0 0 0 0

$BBox -12.477 -40.469 -63.19 0 40.469 63.19

$DefineBone "static_prop" "" 0 0 0 0 0 0 0 0 0 0 0 0


$Sequence "idle" {
	"autoportal_frame_anims\idle.smd"
	activity "ACT_IDLE" 1
	fadein 0.2
	fadeout 0.2
	fps 30
}

$CollisionModel "autoportal_frame_physics.smd"
{
	$mass 1
	$inertia 1
	$damping 0
	$rotdamping 0
	$rootbone " "
	$concave
	$maxconvexpieces 3

}
