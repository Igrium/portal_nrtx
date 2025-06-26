$modelname "props/speaker_system01/speaker_system01.mdl"

$staticprop

$body "body" "speaker_system01.dmx"

$surfaceprop "metal"
$contents "solid"

$cdmaterials "models/props/speaker_system01"

$sequence "idle" "speaker_system01.dmx"

$collisionmodel "speaker_system01_physics.smd"
{
    $mass 100
    $concave
}