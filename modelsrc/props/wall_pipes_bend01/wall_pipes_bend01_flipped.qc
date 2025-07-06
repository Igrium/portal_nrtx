$modelname "props/wall_pipes_bend01/wall_pipes_bend01_flipped.mdl"

$staticprop
$body "body" "wall_pipes_bend01_flipped.dmx"

$surfaceprop "metal"
$contents "solid"

$cdmaterials "models/props/wall_pipes_bend01"

$sequence "idle" "wall_pipes_bend01_flipped.dmx"

$collisionmodel "wall_pipes_bend01_physics.dmx"

$lod 9
{
    replacemodel "wall_pipes_bend01_flipped.dmx" "wall_pipes_bend01_flipped_lod1.dmx"
}