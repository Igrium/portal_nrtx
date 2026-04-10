// Created by Crowbar 0.74

$ModelName "props/table_reference.mdl"

$body "body" "table_rtx_ref.smd"

$staticprop

$SurfaceProp "metalpanel"

$Contents "solid"

$IllumPosition 0 -0.175 11.3

$CDMaterials "models\props\table_reference\"

$CBox 0 0 0 0 0 0

$BBox -17.021 -11.997 -0.247 17.45 11.877 22.734

//$DefineBone "polymsh1" "" 0 0 0 0 0 90 0 0 0 0 0 0


$Sequence "idle" {
	"table_reference_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$CollisionModel "table_reference_physics.smd"
{
	$mass 120
	$inertia 1
	$damping 0
	$rotdamping 0
	$rootbone " "
	$concave
	$maxconvexpieces 9

}
