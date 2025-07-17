$modelname "props/food_can/food_can_open.mdl"

$staticprop

$body "body" "food_can_open.dmx"

$surfaceprop "metal"
$contents "solid"

$cdmaterials "models/props/food_can/"

$sequence "idle" "food_can_open.dmx"

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
    replacemodel "food_can_open.dmx" "food_can_open_lod1.dmx"
}