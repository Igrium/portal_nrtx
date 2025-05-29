$modelname "props_c17\handrail04_singlerise.mdl"

$staticprop

$body "Body" "handrail04_singlerise_reference.smd"

$surfaceprop "metal"

$contents "solid"

$cdmaterials "models\props_c17\"

$sequence "idle" "handrail04_singlerise_reference"

$collisionmodel "handrail04_singlerise_physics.smd"
{
	$concave
}
