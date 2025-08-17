$modelname "props_lab/tpplugholder_single.mdl"
$staticprop

$body "body" "tpplugholder_single.dmx"

$surfaceprop "metalpanel"
$contents "solid"

$cdmaterials "models/props_lab/"

$sequence "idle" "tpplugholder_single.dmx"

$collisionmodel "tpplugholder_single_physics.dmx"

$lod 3
{
    replacemodel "tpplugholder_single.dmx" "tpplugholder_single_lod1.dmx"
}