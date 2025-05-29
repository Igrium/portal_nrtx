$modelname "props_c17\handrail04_medium.mdl"

$staticprop

$body "Body" "handrail04_medium_reference.smd"

$surfaceprop "metal"

$contents "solid"

$cdmaterials "models\props_c17\"

$sequence "idle" "handrail04_medium_reference"

$collisionmodel "handrail04_medium_physics.smd"
{
	$concave
}
