$modelname "props/button_base_reference.mdl"
$staticprop

$body "body" "button_base_reference.dmx"

$surfaceprop "metal"
$contents "solid"

$cdmaterials "models/props/"

$sequence "idle" "button_base_reference.dmx"

$collisionmodel "button_base_reference_physics.dmx"
{
    $mass 120
    $concave
}

$maxverts 30000