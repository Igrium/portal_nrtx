# Portal Without RTX

Nvidia is promoting a false narrative that you need expensive GPUs with RTX to make games "look better", when in reality, the actual necessity is simply high-quality art (which Portal RTX conveniently has.)

So I ported all the Portal RTX assets to Strata to show you don't actually need RTX for it to look good. Get rekt.

## Launching (Steam)

Mods can be launched from Steam if placed in the `steamapps/sourcemods/` folder. Note that you must quit and relaunch Steam for your mod to show up when you first create it.

If you do not wish to launch from Steam, you can also launch via the chaos executable.

## Launching (Alternative)

To launch on Windows: 

```sh
"..\..\common\Portal 2 Community Edition\bin\win64\chaos.exe" -legacyui -game "%cd%"
```

To launch on Linux:

```sh
"../../common/Portal 2 Community Edition/p2ce.sh" -legacyui -game "$PWD"
```