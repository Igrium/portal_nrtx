$modelname "props/lab_chair/lab_chair.mdl"

$staticprop

$body "body" "lab_chair_reference.smd"
$contents "solid"

$cdmaterials "models/props/lab_chair"

$sequence "idle" "lab_chair_reference.smd"

$surfaceprop "metal"

$collisionmodel "lab_chair_physics.smd"
{
    $mass $20
    $concave
}

$keyvalues
{
    prop_data
    {
        "base" "Plastic.Medium"
    }
}

$lod 8
{
    replacemodel "lab_chair_reference.smd" "lab_chair_lod1.smd"
}