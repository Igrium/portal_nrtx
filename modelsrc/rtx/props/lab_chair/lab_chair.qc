// Created by Crowbar 0.74

$ModelName "rtx\props\lab_chair\lab_chair.mdl"

$StaticProp

$BodyGroup "lab_chair"
{
	studio "lab_chair.smd"
}


$SurfaceProp "metal"

$Contents "solid"

$IllumPosition -0.045 0.409 -2.524

$CDMaterials "models\rtx\props\lab_chair\"

$CBox 0 0 0 0 0 0

$BBox -12.059 -12.042 -23.834 11.419 12.019 18.838

$DefineBone "static_prop" "" 0 0 0 0 0 0 0 0 0 0 0 0


$Sequence "idle" {
	"lab_chair_anims\idle.smd"
	activity "ACT_IDLE" 1
	fadein 0.2
	fadeout 0.2
	fps 30
}

$CollisionModel "lab_chair_physics.smd"
{
	$mass 20
	$inertia 1
	$damping 0
	$rotdamping 0
	$rootbone " "
	$concave
	$maxconvexpieces 15

}

$KeyValues
{
	prop_data 
	{
		"base" "Plastic.Medium"
	}
}
