$modelname "props_bts/metal_block.mdl"

$body "body" "metal_block_reference.smd"

$surfaceprop "metal"
$contents "solid"
$cdmaterials "models/props_bts/"

$sequence "idle" "metal_block_reference.smd"

$collisionmodel "metal_block_physics.smd"
{
	$mass 120
	$inertia 1
	$damping 0
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
