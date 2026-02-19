$modelname "props/switch001.mdl"

$body "body" "switch001.dmx"

$lod 15
{
    replacemodel "switch001.dmx" "switch001_lod1.dmx"
}

$surfaceprop "metal"
$contents "solid"

$cdmaterials "models/props"

$sequence "idle"    "switch001_anims/idle.smd"
$sequence "down"    "switch001_anims/down.smd"
$sequence "up"      "switch001_anims/up.smd"


$collisionmodel "switch001_physics.smd"
{
    $mass 120
    $concave
}