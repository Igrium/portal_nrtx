$modelname "props_wasteland/interior_fence003e.mdl"

$staticprop

$body "body" "interior_fence003e_reference.smd"

$surfaceprop    "chainlink"
$contents       "grate"
$cdmaterials    "models/props_wasteland"
$sequence "idle" "interior_fence003e_reference.smd"

$collisionmodel "interior_fence003e_physics.smd"
{
    $concave
}