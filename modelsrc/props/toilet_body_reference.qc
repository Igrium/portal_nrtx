// Created by Crowbar 0.74

$ModelName "props/toilet_body_reference.mdl"

$BodyGroup "Body"
{
	studio "toilet_body.smd"
}

$staticprop

$SurfaceProp "metalpanel"

$Contents "solid"

$IllumPosition 0 -3.163 22.353

$CDMaterials "models\props\toilet_reference\"

$CBox 0 0 0 0 0 0

$BBox -20.062 -11.728 -0.244 26.433 11.866 44.923

//$DefineBone "static_prop" "" 0 0 0 0 0 89.999982 0 0 0 0 0 0


$Sequence "idle" {
	"toilet_body_reference_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$CollisionModel "toilet_body_reference_physics.smd"
{
	$mass 120
	$inertia 1
	$damping 0
	$rotdamping 0
	$rootbone " "
	$concave
	$maxconvexpieces 20

}
