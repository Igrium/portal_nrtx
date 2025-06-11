$modelname "props_wasteland/interior_fence003d.mdl"

$staticprop

$body "body" "interior_fence003d_reference.smd"

$surfaceprop    "chainlink"
$contents       "grate"
$cdmaterials    "models/props_wasteland"
$sequence "idle" "interior_fence003d_reference.smd"

$collisionmodel "interior_fence003d_physics.smd"
{
    $concave
}