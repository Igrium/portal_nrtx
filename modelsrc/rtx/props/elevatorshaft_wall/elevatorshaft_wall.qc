// Created by Crowbar 0.74

$ModelName "rtx/props/elevatorshaft_wall/elevatorshaft_wall.mdl"

$StaticProp

$BodyGroup "elevatorshaft_wall"
{
	studio "elevatorshaft_wall_rtx.smd"
}


$SurfaceProp "metal"

$Contents "solid"

$IllumPosition 0.021 159.589 0

$CDMaterials "models\rtx\props\elevatorshaft_wall\"

$CBox 0 0 0 0 0 0

$BBox -336.576 -144.721 -97.39 1.34 144.97 97.39

$DefineBone "static_prop" "" 0 0 0 0 0 0 0 0 0 0 0 0


$Sequence "idle" {
	"elevatorshaft_wall_anims\idle.smd"
	activity "ACT_IDLE" 1
	fadein 0.2
	fadeout 0.2
	fps 30
}

$CollisionModel "elevatorshaft_wall_physics.smd"
{
	$mass 1
	$inertia 1
	$damping 0
	$rotdamping 0
	$rootbone " "
	$concave
	$maxconvexpieces 9

}
