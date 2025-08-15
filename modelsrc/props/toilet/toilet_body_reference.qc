$modelname "props/toilet_body_reference.mdl"
$staticprop

$body "body" "toilet_body.dmx"
$surfaceprop "metalpanel"
$contents "solid"

$cdmaterials "models/props"

$sequence "idle" "toilet_body.dmx"

$collisionmodel "toilet_body_physics.dmx"
{
    $mass 120
    $inertia 1
    $concave
    $rootbone " "
}

$lod 7
{
    replacemodel "toilet_body.dmx" "toilet_body_lod1.dmx"
}