$modelname "props/128_fuse_set09/128_fuse_set09.mdl"

$staticprop

$body "body" "128_fuse_set09.dmx"
$surfaceprop "metal"
$contents "solid"

$cdmaterials "models/props/128_fuse_set09"

$sequence "idle" "128_fuse_set09.dmx"

$collisionmodel "128_fuse_set09_physics.smd"

$lod 7 
{
    replacemodel "128_fuse_set09.dmx" "128_fuse_set09_lod1.dmx"
}