$modelname "props_wasteland/interior_fence002d.mdl"

$staticprop

$body "body" "interior_fence002d_reference.smd"

$surfaceprop    "chainlink"
$contents       "grate"
$cdmaterials    "models/props_wasteland"
$sequence "idle" "interior_fence002d_reference.smd"

$collisionmodel "interior_fence002d_physics.smd"
{
    $concave
}