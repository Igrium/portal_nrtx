$modelname "props/wall_pipes_corner/wall_pipes_corner.mdl"

$staticprop
$body "body" "wall_pipes_corner.dmx"

$surfaceprop "metal"
$contents "solid"

$cdmaterials "models/props/wall_pipes_corner"

$sequence "idle" "wall_pipes_corner.dmx"

$collisionmodel "wall_pipes_corner_physics.smd"
{
    $mass 100
    $concave
}

// $lod 9
// {
//     replacemodel "wall_pipes_corner.dmx" "wall_pipes_corner_lod1.dmx"
// }