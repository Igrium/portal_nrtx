$modelname "props/pc_case02/pc_case02.mdl"

$staticprop

$body "body" "pc_case02.smd"

$surfaceprop    "metal"
$contents       "solid"

$cdmaterials "models/props/pc_case02"

$sequence "idle" "pc_case02.smd"

$collisionmodel "pc_case02_physics.smd"
{
    $mass 8
    $concave
}

$keyvalues
{
	prop_data 
	{
		"base" "Plastic.Medium"
	}
}
