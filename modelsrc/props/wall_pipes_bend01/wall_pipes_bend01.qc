$modelname "props/wall_pipes_bend01/wall_pipes_bend01.mdl"

$staticprop
$body "body" "wall_pipes_bend01.dmx"

$surfaceprop "metal"
$contents "solid"

$cdmaterials "models/props/wall_pipes_bend01"

$sequence "idle" "wall_pipes_bend01.dmx"

$collisionmodel "wall_pipes_bend01_physics.dmx"

$lod 9
{
    replacemodel "wall_pipes_bend01.dmx" "wall_pipes_bend01_lod1.dmx"
}