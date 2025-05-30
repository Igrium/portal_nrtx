$modelname "props_wasteland/interior_fence002a.mdl"

$staticprop

$body "body" "interior_fence002a_reference.smd"

$surfaceprop    "chainlink"
$contents       "grate"
$cdmaterials    "models/props_wasteland"
$sequence "idle" "interior_fence002a_reference.smd"

$collisionmodel "interior_fence002a_physics.smd"
{
    $concave
}