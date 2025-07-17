$modelname "props/milk_carton/milk_carton_open.mdl"

$staticprop

$body "body" "milk_carton_open.dmx"

$surfaceprop "papercup"
$contents "solid"

$sequence "idle" "milk_carton_open.dmx"

$cdmaterials "models/props/milk_carton/"


$collisionmodel "milk_carton_open_physics.dmx"
{
    $mass 0.2
    $concave
}

$keyvalues
{
    prop_data 
    {
        "base" "cardboard.small"
    }
}
