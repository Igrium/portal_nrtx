$modelname "props/button_top_reference.mdl"
$staticprop

$body "body" "button_top_reference.dmx"

$surfaceprop "metal"
$contents "solid"

$cdmaterials "models/props/"

$sequence "idle" "button_top_reference.dmx"

$collisionmodel "button_top_reference_physics.dmx"
{
    $mass 120
    $concave
}

// $definebone "button_whole_reference_02.polymsh" "" 0 0 0 0 0 89.999982 0 0 0 0 0 0
