$modelname "props/wall_pipes_tjunc01/wall_pipes_tjunc01.mdl"

$staticprop
$body "body" "wall_pipes_tjunc01.dmx"

$surfaceprop "metal"
$contents "solid"

$cdmaterials "models/props/wall_pipes_tjunc01"

$sequence "idle" "wall_pipes_tjunc01.dmx"

$collisionmodel "wall_pipes_tjunc01_physics.dmx"

// $lod 9
// {
//     replacemodel "wall_pipes_tjunc01.dmx" "wall_pipes_tjunc01_lod1.dmx"
// }