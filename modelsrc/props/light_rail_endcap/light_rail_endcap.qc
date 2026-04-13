$modelname "props/light_rail_endcap.mdl"

$body "body" "light_rail_endcap.dmx"

$surfaceprop "metal"
$contents "solid"

$cdmaterials "models/props"

$sequence "idle" "light_rail_endcap.dmx"

$sequence "movedown" {
    "anims/movedown.dmx"
    fps 30
}

$collisionmodel "light_rail_endcap_physics.dmx"
{
    $mass 100
    $concave
}