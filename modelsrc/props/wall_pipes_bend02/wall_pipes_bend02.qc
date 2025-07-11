$modelname "props/wall_pipes_bend02/wall_pipes_bend02.mdl"

$staticprop
$body "body" "wall_pipes_bend02.dmx"

$surfaceprop "metal"
$contents "solid"

$cdmaterials "models/props/wall_pipes_bend02"

$sequence "idle" "wall_pipes_bend02.dmx"

$collisionmodel "wall_pipes_bend02_physics.dmx"

// $lod 9
// {
//     replacemodel "wall_pipes_bend02.dmx" "wall_pipes_bend02_lod1.dmx"
// }