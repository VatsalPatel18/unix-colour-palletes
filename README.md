# unix-colour-palletes

Custom Ptyxis terminal palettes, matching wallpapers, and a small activation script.

## Palettes

- `HAWK-PRIME`
- `HAWTHORN-BLOOM`
- `FORGET-ME-NOT`
- `DAHLIA-MONO`
- `DRONE-REDLINE`
- `LILAC-SPRING`

## Layout

- `palettes/` contains the `.palette` files.
- `wallpapers/` contains the source wallpapers, renamed with palette prefixes.
- `scripts/activate-palette.sh` installs and activates one palette in Ptyxis.

## Wallpaper Pairing

- `HAWK-PRIME` -> `wallpapers/HAWK-PRIME__avocado_minimalism_pink_120543_1920x1200.jpg`
- `HAWK-PRIME` -> `wallpapers/HAWK-PRIME__bulb_lighting_rope_130830_1920x1200.jpg`
- `HAWK-PRIME` -> `wallpapers/HAWK-PRIME__headphones_camera_retro_122094_1920x1200.jpg`
- `HAWTHORN-BLOOM` -> `wallpapers/HAWTHORN-BLOOM__hawthorn_flowers_petals_1599528_6000x3374.jpg`
- `HAWTHORN-BLOOM` -> `wallpapers/HAWTHORN-BLOOM__court_trees_top_view_122829_1920x1200.jpg`
- `FORGET-ME-NOT` -> `wallpapers/FORGET-ME-NOT__forgetmenot_petals_flower_1590335_7647x5098.jpg`
- `DAHLIA-MONO` -> `wallpapers/DAHLIA-MONO__dahlia_flower_petals_1609744_4584x2847.jpg`
- `DRONE-REDLINE` -> `wallpapers/DRONE-REDLINE__drone_camera_technology_171576_4742x5927.jpg`
- `LILAC-SPRING` -> `wallpapers/LILAC-SPRING__lilac_flowers_branch_1569703_3725x2561.jpg`

## Usage

To activate a palette in the current Ubuntu/Ptyxis setup:

```bash
./scripts/activate-palette.sh DAHLIA-MONO
```

If you omit the name, the script prints a list and prompts you to choose.
