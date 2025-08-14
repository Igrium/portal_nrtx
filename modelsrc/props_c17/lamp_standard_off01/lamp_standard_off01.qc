$modelname "props_c17/lamp_standard_off01.mdl"

$staticprop

$body "body" "lamp_standard_off01.dmx"
$surfaceprop "metal"
$contents "solid"

$cdmaterials "models/props_c17"

$texturegroup "skins"
{
    { "lamp_standard01" }
    { "lamp_standard01_on" }
}

$sequence "idle" "lamp_standard_off01.dmx"

$collisionmodel "lamp_standard_off01_physics.smd"
{
    $mass 4.645161
    $inertia 1
    $damping 0
    $rotdamping 0
    $concave
}

$keyvalues
{
    prop_data 
    {
        "base" "Metal.Small"
    }
}

$lod 5
{
    replacemodel "lamp_standard_off01.dmx" "lamp_standard_off01_lod1.dmx"
}