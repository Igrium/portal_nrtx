$modelname "props_c17\handrail04_long.mdl"

$staticprop

$body "Body" "handrail04_long_reference.smd"

$surfaceprop "metal"

$contents "solid"

$cdmaterials "models\props_c17\"

$sequence "idle" "handrail04_long_reference"

$collisionmodel "handrail04_long_physics.smd"
{
	$concave
}

$keyvalues
{
	prop_data 
	{
		"base" "Metal.Large"
		"allowstatic" "1"
	}
}
