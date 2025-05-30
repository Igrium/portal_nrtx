$modelname "props_wasteland/interior_fence002c.mdl"

$staticprop

$body "body" "interior_fence002c_reference.smd"

$surfaceprop    "chainlink"
$contents       "grate"
$cdmaterials    "models/props_wasteland"
$sequence "idle" "interior_fence002c_reference.smd"

$collisionmodel "interior_fence002c_physics.smd"
{
    $concave
}