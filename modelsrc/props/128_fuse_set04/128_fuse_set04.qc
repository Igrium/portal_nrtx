$modelname "props/128_fuse_set04/128_fuse_set04.mdl"

$staticprop

$body "body" "128_fuse_set04.dmx"
$surfaceprop "metal"
$contents "solid"

$cdmaterials "models/props/128_fuse_set04"

$sequence "idle" "128_fuse_set04.dmx"

$collisionmodel "128_fuse_set04_physics.smd"

$lod 4 {
    replacemodel "128_fuse_set04.dmx" "128_fuse_set04_lod1.dmx"
}