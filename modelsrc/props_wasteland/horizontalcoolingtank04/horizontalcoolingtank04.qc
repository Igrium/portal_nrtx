$modelname "props_wasteland\horizontalcoolingtank04.mdl"
$staticprop

$body "body" "horizontalcoolingtank04_reference.dmx"

$surfaceprop "metal"
$contents "solid"

$cdmaterials "models/props_wasteland/"

$sequence "idle" "horizontalcoolingtank04_reference.dmx"

$collisionmodel "horizontalcoolingtank04_physics.dmx"
{
    $mass 4000
    $concave
}