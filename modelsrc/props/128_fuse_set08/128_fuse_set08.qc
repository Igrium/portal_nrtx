$modelname "props/128_fuse_set08/128_fuse_set08.mdl"

$staticprop

$body "body" "128_fuse_set08.dmx"
$surfaceprop "metal"
$contents "solid"

$cdmaterials "models/props/128_fuse_set08"

$sequence "idle" "128_fuse_set08.dmx"

$collisionmodel "128_fuse_set08_physics.smd"

$lod 7 
{
    replacemodel "128_fuse_set08.dmx" "128_fuse_set08_lod1.dmx"
}