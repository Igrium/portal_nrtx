$modelname "props/lift_platform.mdl"

$body "body" "lift_platform.dmx"

$surfaceprop "metal"
$contents "solid"
$staticprop

$cdmaterials "models/props"

$sequence "idle" "lift_platform.dmx"

$collisionmodel "lift_platform_physics.dmx"
{
    $mass 30
    $concave
}

$lod 15
{
    replacemodel "lift_platform.dmx" "lift_platform_lod1.dmx"
}
