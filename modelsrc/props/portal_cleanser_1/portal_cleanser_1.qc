$modelname "props/portal_cleanser_1.mdl"
$staticprop

$body "body" "portal_cleanser_1_reference.dmx"
$body "glass" "portal_cleanser_1_glass.dmx"

$lod 10
{
    replacemodel "portal_cleanser_1_reference.dmx" "portal_cleanser_1_lod1.dmx"
}

$lod 35
{
    replacemodel "portal_cleanser_1_reference.dmx" "portal_cleanser_1_lod2.dmx"
}

$surfaceprop "metal"

$contents "solid"
$mostlyopaque

$cdmaterials "models/props/portal_cleanser"

$sequence "idle" "portal_cleanser_1_reference.dmx"

$collisionmodel "portal_cleanser_1_physics.dmx"