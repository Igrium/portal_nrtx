$modelname "props/door_02.mdl"

$body "body" "door_02.dmx"

$surfaceprop "metal"
$contents "solid"
$staticprop

$cdmaterials "models/props"

$texturegroup "skins"
{
    { "door_02" }
    { "door_02_a" }
    { "door_02_b" }
}

$sequence "idle" "door_02.dmx"

$collisionmodel "door_02_physics.dmx"
