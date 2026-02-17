$modelname "props/button_base_reference.mdl"

$body "body" "button_base.dmx"

$surfaceprop "metal"
$contents "solid"
$staticprop

$cdmaterials "models/props"

$sequence "idle" "button_base_reference.dmx"

$collisionmodel "button_base_reference_physics.smd"
{
    $mass 120
    $concave
}