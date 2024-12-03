
$modelname "props/metal_box.mdl"

$body body "metal_box.smd"
$sequence "idle" "metal_box.smd"

$surfaceprop "metalpanel"

$contents "solid"

$cdmaterials "models/props/"

$texturegroup "skins"
{
	{ "metal_box" }
	{ "metal_box_companion" }
	{ "metal_box_powered" }
}

$collisionmodel "metal_box_phys.smd"
{
	$mass 40
	$inertia 1
	$damping 0.1
	$rotdamping 0
	$rootbone " "
}

$keyvalues
{
	prop_data 
	{
		"base" "Metal.small"
	}
}
