$modelname "props/wall_pipes_wave/wall_pipes_wave_flipped.mdl"

$staticprop
$body "body" "wall_pipes_wave_flipped.dmx"

$surfaceprop "metal"
$contents "solid"

$cdmaterials "models/props/wall_pipes_wave"

$sequence "idle" "wall_pipes_wave_flipped.dmx"

$collisionmodel "wall_pipes_wave_physics.dmx"

// $lod 9
// {
//     replacemodel "wall_pipes_wave.dmx" "wall_pipes_wave_lod1.dmx"
// }