// Created by Crowbar 0.74

$ModelName "props\autoportal_frame\autoportal_frame.mdl"

$StaticProp

$body "body" "portal_frame_rtx.smd"


$SurfaceProp "metal"

$Contents "solid"

$IllumPosition 0 6.074 0

$CDMaterials "models\props\autoportal_frame\"

$CBox 0 0 0 0 0 0

$BBox -12.477 -40.469 -63.19 0 40.469 63.19

$DefineBone "static_prop" "" 0 0 0 0 0 0 0 0 0 0 0 0


$sequence "idle" "portal_frame_rtx.smd"

$CollisionModel "autoportal_frame_physics.smd"
{
	$concave
}
