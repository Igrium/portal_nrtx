// Created by Crowbar 0.74

$ModelName "props\sign_frame02\sign_frame02.mdl"

$StaticProp

$BodyGroup "sign_frame02"
{
	studio "sign_frame02.smd"
}


$SurfaceProp "metal"

$Contents "solid"

$IllumPosition 0 1.674 0

$CDMaterials "models\rtx/props\sign_frame02\"

$CBox 0 0 0 0 0 0

$BBox -4.107 -37 -18 0.823 37 18

$DefineBone "static_prop" "" 0 0 0 0 0 0 0 0 0 0 0 0


$Sequence "idle" {
	"sign_frame02_anims\idle.smd"
	activity "ACT_IDLE" 1
	fadein 0.2
	fadeout 0.2
	fps 30
}

$CollisionModel "sign_frame02_physics.smd"
{
	$mass 1
	$inertia 1
	$damping 0
	$rotdamping 0
	$rootbone " "
	$concave
	$maxconvexpieces 1

}
