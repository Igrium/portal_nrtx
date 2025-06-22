$modelname "props/128_fuse_set01/128_fuse_set01.mdl"

$staticprop

$body "body" "128_fuse_set01.dmx"
$surfaceprop "metal"
$contents "solid"

$cdmaterials "models/props/128_fuse_set01"

$sequence "idle" "128_fuse_set01.dmx"

$collisionmodel "128_fuse_set01_physics.smd"
{
    $mass 100
    $concave
}

$lod 6 {
    replacemodel "128_fuse_set01.dmx" "128_fuse_set01_lod1.dmx"
}