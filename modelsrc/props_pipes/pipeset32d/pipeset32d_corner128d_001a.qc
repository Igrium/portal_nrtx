$modelname "props_pipes/pipeset32d_corner128d_001a.mdl"

$staticprop

$body "body" "pipeset32d_corner128d_001a.dmx"

$lod 19
{
    replacemodel "pipeset32d_corner128d_001a.dmx" "pipeset32d_corner128d_001a_lod1.dmx"
}

$surfaceprop metal
$contents solid

$cdmaterials "models/props_pipes"

$sequence "idle" "pipeset32d_corner128d_001a.dmx"

$collisionmodel "pipeset32d_corner128d_001a_physics.dmx"
{
    $mass 444
    $concave
}