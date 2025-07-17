$modelname "props_junk/MetalBucket01a.mdl"
$staticprop

$body "body" "metalbucket01a_reference.dmx"

$surfaceprop "metal"
$contents "solid"

$cdmaterials "models/props_junk/"


$sequence "idle" "metalbucket01a_reference.dmx"

$collisionmodel "metalbucket01a_physics.dmx"
{
    $mass 8
}

$lod 4 
{
    replacemodel "metalbucket01a_reference.dmx" "metalbucket01a_lod1.dmx"
}

$keyvalues
{
    prop_data 
    {
        "base" "Metal.Small"
    }
}
