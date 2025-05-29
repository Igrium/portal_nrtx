$modelname "props_c17\handrail04_short.mdl"

$staticprop

$body "Body" "handrail04_short_reference.smd"

$surfaceprop "metal"

$contents "solid"

$cdmaterials "models\props_c17\"

$sequence "idle" "handrail04_short_reference"

$collisionmodel "handrail04_short_physics.smd"
{
	$concave
}
