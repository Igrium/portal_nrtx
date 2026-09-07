$modelname "props_bts/bts_stool_static.mdl"

$staticprop
$cdmaterials "models/props_bts/"

$body "body" "bts_stool_reference.dmx"

$surfaceprop "metal"
$contents "solid"

$sequence "idle" "bts_stool_reference.dmx"

$collisionmodel "bts_stool_physics.dmx"
{
    $mass 50
    $concave
}

$lod 3
{
    replacemodel "bts_stool_reference.dmx" "bts_stool_lod1.dmx"
}