$modelname "props/food_can/food_can.mdl"

$staticprop

$body "body" "food_can.dmx"

$surfaceprop "metal"
$contents "solid"

$cdmaterials "models/props/food_can/"

$sequence "idle" "food_can.dmx"

$collisionmodel "food_can_physics.dmx"
{
    $mass 1
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
    replacemodel "food_can.dmx" "food_can_lod1.dmx"
}