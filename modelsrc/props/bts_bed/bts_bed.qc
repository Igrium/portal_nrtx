$modelname "props/bts_bed/bts_bed.mdl"

$staticprop

$body "body" "bts_bed.dmx"

$surfaceprop "cardboard.small"
$contents "solid"

$cdmaterials "models/props/bts_bed/"

$sequence "idle" "bts_bed.dmx"

$collisionmodel "bts_bed_physics.dmx"
{
    $mass 1
    $concave
}

$lod 6
{
    replacemodel "bts_bed.dmx" "bts_bed_lod1.dmx"
}