$modelname "props\saucepan\saucepan.mdl"

$staticprop

$body "body" "saucepan.dmx"

$surfaceprop "metal"
$contents "solid"
$cdmaterials "models/props/saucepan"

$sequence "idle" "saucepan.dmx"

$collisionmodel "saucepan_physics.dmx"
{
    $mass 2
    $concave
}

$keyvalues
{
    prop_data 
    {
        "base" "Plastic.Medium"
    }
}

$lod 4
{
    replacemodel "saucepan.dmx" "saucepan_lod1.dmx"
}