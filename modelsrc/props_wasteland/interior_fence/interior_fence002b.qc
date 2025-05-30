$modelname "props_wasteland/interior_fence002b.mdl"

$staticprop

$body "body" "interior_fence002b_reference.smd"

$surfaceprop    "chainlink"
$contents       "grate"
$cdmaterials    "models/props_wasteland"
$sequence "idle" "interior_fence002b_reference.smd"

$collisionmodel "interior_fence002b_physics.smd"
{
    $concave
}