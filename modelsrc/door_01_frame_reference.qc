// Created by Crowbar 0.74

$ModelName "rtx/props/Door_01_Frame_reference.mdl"

$StaticProp

$BodyGroup "Body"
{
	studio "frame_thin.smd"
}

//$LOD 25
//{
//	replacemodel "Door_01_Frame_reference.smd" "Door_01_Frame_reference_lod1.smd"
//	NoFacial
//}
//$LOD 50
//{
//	replacemodel "Door_01_Frame_reference.smd" "Door_01_Frame_reference_lod2.smd"
//	NoFacial
//}

$SurfaceProp "metal"

$Contents "solid"

$IllumPosition 0 0.001 54.117

$CDMaterials "models\rtx/props\door_01\"

$CBox 0 0 0 0 0 0

$BBox -9.25 -64.25 -0.258 9.25 64.25 108.464

$DefineBone "static_prop" "" 0 0 0 0 0 0 0 0 0 0 0 0


$Sequence "idle" {
	"door_01_frame_reference_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$CollisionModel "door_01_frame_reference_physics.smd"
{
	$mass 120
	$inertia 1
	$damping 0
	$rotdamping 0
	$rootbone " "
	$concave
	$maxconvexpieces 10

}
