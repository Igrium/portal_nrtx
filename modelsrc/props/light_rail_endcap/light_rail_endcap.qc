$modelname "props/light_rail_endcap.mdl"

$body "body" "light_rail_endcap.dmx"

$surfaceprop "metal"
$contents "solid"

$cdmaterials "models/props"

// $definebone "Root" "" 0 0 0 0 0 89.999982 0 0 0 0 0 0
// $definebone "Brackets" "Root" 0 64.970528 0 0 0 0 0 0 0 0 0 0

// $sequence "idle" "light_rail_endcap.dmx"

$sequence "idle" {
    "light_rail_endcap_anims/idle.smd"
    fadein 0.2
    fadeout 0.2
    fps 30
}

// $sequence "movedown" {
//     "anims/movedown.dmx"
//     fadein 0.2
//     fadeout 0.2
//     fps 30
// }

$sequence "movedown" {
    "light_rail_endcap_anims/movedown.smd"
    fadein 0.2
    fadeout 0.2
    fps 30
}

$collisionmodel "light_rail_endcap_physics.dmx"
{
    $mass 100
    $concave
}