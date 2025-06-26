$modelname "props/speaker_system01/speaker_system02.mdl"

$staticprop

$body "body" "speaker_system02.dmx"

$surfaceprop "metal"
$contents "solid"

$cdmaterials "models/props/speaker_system01"

$sequence "idle" "speaker_system02.dmx"

$collisionmodel "speaker_system02_physics.smd"
{
    $mass 100
    $concave
}