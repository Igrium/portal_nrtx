$modelname "props/wall_pipes_horiz/wall_pipes_horiz.mdl"

$staticprop
$body "body" "wall_pipes_horiz.dmx"

$surfaceprop "metal"
$contents "solid"

$cdmaterials "models/props/wall_pipes_horiz"

$sequence "idle" "wall_pipes_horiz.dmx"

$collisionmodel "wall_pipes_horiz_physics.dmx"

// $lod 9
// {
//     replacemodel "wall_pipes_horiz.dmx" "wall_pipes_horiz_lod1.dmx"
// }