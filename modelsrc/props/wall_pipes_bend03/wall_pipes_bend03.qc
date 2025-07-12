$modelname "props/wall_pipes_bend03/wall_pipes_bend03.mdl"

$staticprop
$body "body" "wall_pipes_bend03.dmx"

$surfaceprop "metal"
$contents "solid"

$cdmaterials "models/props/wall_pipes_bend03"

$sequence "idle" "wall_pipes_bend03.dmx"

$collisionmodel "wall_pipes_bend03_physics.dmx"

// $lod 9
// {
//     replacemodel "wall_pipes_bend03.dmx" "wall_pipes_bend03_lod1.dmx"
// }