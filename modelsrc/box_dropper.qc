// Created by Crowbar 0.74

$ModelName "rtx/props/Box_dropper.mdl"

$StaticProp

$MostlyOpaque

$BodyGroup "Body"
{
	studio "Box_dropper.smd"
}

//$LOD 40
//{
//	replacemodel "Box_dropper_reference.smd" "Box_dropper_reference_lod1.smd"
//	NoFacial
//}

$SurfaceProp "metalpanel"

$Contents "solid"

$IllumPosition 0.041 0 50.045

$CDMaterials "models\rtx\props\vactubes"

$CBox 0 0 0 0 0 0

$BBox -54.271 -54.23 0 54.271 54.313 100.146

$DefineBone "static_prop" "" 0 0 0 0 0 0 0 0 0 0 0 0


$Sequence "idle" {
	"box_dropper_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$CollisionModel "box_dropper_physics.smd"
{
	$mass 120
	$inertia 1
	$damping 0
	$rotdamping 0
	$rootbone " "
	$concave
	$maxconvexpieces 9

}
