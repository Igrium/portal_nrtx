// Created by Crowbar 0.74

$ModelName "rtx/props/Clock.mdl"

$BodyGroup "Body"
{
	studio "Clock_rtx.smd"
}


$SurfaceProp "metal"

$Contents "solid"

$IllumPosition 0 0 3.114

$CDMaterials "models\rtx/props\clock\"

$CBox 0 0 0 0 0 0

$BBox -15.159 -43.433 -0.25 15.159 43.433 6.477

$DefineBone "polymsh" "" 0 0 0 0 0 89.999982 0 0 0 0 0 0


$Sequence "idle" {
	"clock_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$CollisionModel "clock_physics.smd"
{
	$mass 120
	$inertia 1
	$damping 0
	$rotdamping 0
	$rootbone " "
	$concave
	$maxconvexpieces 1

}
