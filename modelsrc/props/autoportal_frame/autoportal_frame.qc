$modelname "props/autoportal_frame/autoportal_frame.mdl"
$staticprop

$body "body" "autoportal_frame.dmx"

$surfaceprop "metal"
$contents "solid"

$cdmaterials "models/props/autoportal_frame"

$sequence "idle" "autoportal_frame.dmx"

$collisionmodel "autoportal_frame_physics.dmx"
{
    $mass 100
    $concave
}