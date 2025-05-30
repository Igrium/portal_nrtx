$modelname "props_wasteland/interior_fence002e.mdl"

$staticprop

$body "body" "interior_fence002e_reference.smd"

$surfaceprop    "chainlink"
$contents       "grate"
$cdmaterials    "models/props_wasteland"
$sequence "idle" "interior_fence002e_reference.smd"

$collisionmodel "interior_fence002e_physics.smd"
{
    $concave
}