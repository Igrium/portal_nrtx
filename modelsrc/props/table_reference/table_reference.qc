$modelname "props/table_reference.mdl"
$staticprop

$body "body" "table_reference.dmx"

$surfaceprop "metalpanel"
$contents "solid"

$cdmaterials "models/props"

$sequence "idle" "table_reference.dmx"

$collisionmodel "table_reference_physics.dmx"
{
    $mass 120
    $concave
}