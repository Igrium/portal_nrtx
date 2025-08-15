$modelname "props/radio_reference.mdl"
$staticprop

$body "body" "radio_reference.dmx"

$surfaceprop "metalpanel"
$contents "solid"

$cdmaterials "models/props/"

$sequence "idle" "radio_reference.dmx"

$collisionmodel "radio_reference_physics.dmx"
{
    $mass 30
    $inertia 1
    $damping 0
    $rotdamping 0
    $concave
}
