$modelname "props_wasteland/interior_fence003b.mdl"

$staticprop

$body "body" "interior_fence003b_reference.smd"

$surfaceprop    "chainlink"
$contents       "grate"
$cdmaterials    "models/props_wasteland"
$sequence "idle" "interior_fence003b_reference.smd"

$collisionmodel "interior_fence003b_physics.smd"
{
    $concave
}