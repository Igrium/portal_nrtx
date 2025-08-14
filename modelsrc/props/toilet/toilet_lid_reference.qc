$modelname "props/toilet_lid_reference.mdl"

$body "body" "toilet_lid.dmx"
$surfaceprop "metalpanel"
$contents "solid"

$cdmaterials "models/props"

$sequence "idle" "toilet_lid.dmx"

$collisionmodel "toilet_lid_physics.dmx"
{
    $mass 120
    $inertia 1
    $concave
    $rootbone " "
}

$lod 7
{
    replacemodel "toilet_lid.dmx" "toilet_lid_lod1.dmx"
}