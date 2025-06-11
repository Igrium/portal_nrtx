$modelname "props_wasteland/interior_fence003a.mdl"

$staticprop

$body "body" "interior_fence003a_reference.smd"

$surfaceprop    "chainlink"
$contents       "grate"
$cdmaterials    "models/props_wasteland"
$sequence "idle" "interior_fence003a_reference.smd"

$collisionmodel "interior_fence003a_physics.smd"
{
    $concave
}