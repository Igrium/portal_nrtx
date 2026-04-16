// Created by Crowbar 0.74

$ModelName "props/4090_scaled.mdl"

$BodyGroup "Body"
{
	studio "4090_decimated_scaled.smd"
}


$SurfaceProp "metalpanel"

$Contents "solid"

$IllumPosition 0 0 15.422

$CDMaterials "models\props\rtx_card\"

$CBox 0 0 0 0 0 0

$BBox 0 0 0 0 0 0

$DefineBone "card" "" 0 0 0 0 0 0 0 0 0 0 0 0


$Sequence "idle" {
	"4090_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$CollisionModel "4090_phys_scaled.smd"
{
	$mass 2.25
	$inertia 1
	$damping 0
	$rotdamping 0
	$rootbone " "
	$concave
	$maxconvexpieces 4

}
$KeyValues
{
	prop_data 
	{
		"base" "Metal.small"
	}
}
