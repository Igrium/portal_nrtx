$modelname "props/pc_case_open/pc_case_open.mdl"

$staticprop

$body "body" "pc_case_open.smd"

$surfaceprop    "metal"
$contents       "solid"

$cdmaterials "models/props/pc_case_open"

$sequence "idle" "pc_case_open.smd"

$collisionmodel "pc_case_open_physics.smd"
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
