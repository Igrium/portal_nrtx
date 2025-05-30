$modelname "props_wasteland/interior_fence001g.mdl"

$staticprop

$body "body" "interior_fence001g_reference.smd"

$surfaceprop    "chainlink"
$contents       "grate"
$cdmaterials    "models/props_wasteland"
$sequence "idle" "interior_fence001g_reference.smd"

$collisionmodel "interior_fence001g_physics.smd"
{
    $concave
}