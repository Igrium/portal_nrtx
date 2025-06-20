$modelname "props_canal/generator01.mdl"
$staticprop

$body "body" "generator01_reference.dmx"
$maxverts 30000

$surfaceprop "metal"
$contents "solid"

$cdmaterials "models/props_canal"

$sequence "idle" "generator01_reference.dmx"

$collisionmodel "generator01_physics.smd"
{
    $mass 100
    $concave
}