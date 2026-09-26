# unix-colour-palletes

Custom Ptyxis terminal palettes, matching wallpapers, and a small activation script.

The collection currently contains **13 custom palettes** and **15 paired source wallpapers**.

## Palettes

- `HAWK-PRIME`
- `HAWTHORN-BLOOM`
- `FORGET-ME-NOT`
- `DAHLIA-MONO`
- `DRONE-REDLINE`
- `LILAC-SPRING`
- `FROSTBLOOM`
- `COASTAL-HORIZON`
- `BLUE-EYED-BLOOM`
- `EMBER-MARKET`
- `NEON-KIMONO`
- `GLASS-WATER`
- `LILAC-GLOW`

## Design Model: Palette + Effect

The collection treats terminal appearance as layers rather than duplicating a palette for every variation.

| Layer | Controls | Example |
| --- | --- | --- |
| Base palette | Foreground, background tint, cursor, and ANSI colors | `NEON-KIMONO` |
| Profile effect | Window opacity and other Ptyxis profile settings | `--glass` |
| Wallpaper | The desktop image visible behind a translucent terminal | `NEON-KIMONO__girl_kimono_backlight_1168423_1600x900.jpg` |

The reusable `--glass` effect sets the selected palette's Ptyxis profile to 78% opacity. It does not modify or duplicate the underlying `.palette` file. Normal and glass profiles are kept separately, so `NEON-KIMONO` and `NEON-KIMONO-GLASS` can coexist.

`GLASS-WATER` remains a standalone water-tinted base palette and enables the glass effect by default. It is not a copy of `NEON-KIMONO`. A true Neon Kimono glass combination is created by applying `--glass` to `NEON-KIMONO`.

Ptyxis supports profile opacity but does not provide a native per-profile background-image setting. The glass effect therefore reveals the desktop wallpaper or windows behind the terminal; it does not embed an image inside the terminal itself.

## Layout

- `palettes/` contains the `.palette` files.
- `wallpapers/` contains the source wallpapers, renamed with palette prefixes.
- `scripts/activate-palette.sh` installs and activates one palette in Ptyxis.
- `skills/ptyxis-palette-studio/` contains the reusable Codex skill for creating and publishing new image-derived palettes.

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
- `FROSTBLOOM` -> `wallpapers/FROSTBLOOM__flowers_frost_petals_1479314_7371x4914.jpg`
- `COASTAL-HORIZON` -> `wallpapers/COASTAL-HORIZON__sea_rocks_coast_1679424_3840x2160.jpg`
- `BLUE-EYED-BLOOM` -> `wallpapers/BLUE-EYED-BLOOM__flower_petals_plant_1682116_3840x2160.jpg`
- `EMBER-MARKET` -> `wallpapers/EMBER-MARKET__girl_redhead_street_1086393_1920x1080.jpg`
- `NEON-KIMONO` -> `wallpapers/NEON-KIMONO__girl_kimono_backlight_1168423_1600x900.jpg`
- `LILAC-GLOW` -> `wallpapers/LILAC-GLOW__lilac_flowers_branch_1691525_1920x1200.jpg`

## Usage

To activate a palette in the current Ubuntu/Ptyxis setup:

```bash
./scripts/activate-palette.sh DAHLIA-MONO
```

Apply the reusable glass effect to any palette:

```bash
./scripts/activate-palette.sh NEON-KIMONO --glass
./scripts/activate-palette.sh COASTAL-HORIZON --glass
```

`GLASS-WATER` uses 78% opacity automatically:

```bash
./scripts/activate-palette.sh GLASS-WATER
```

If you omit the name, the script prints a list and prompts you to choose.

## Codex Skill

The installed `$ptyxis-palette-studio` skill captures this collection's naming, storage, verification, and publishing workflow. For every new image, specify either **normal** or **Glass Water** style. If the mode is omitted, the skill asks before changing files.

```text
Use $ptyxis-palette-studio to create a normal palette from this image.
Use $ptyxis-palette-studio to create a Glass Water palette from this image.
```

Glass Water remains a reusable profile effect: one base palette and raw wallpaper are stored, while normal and glass profiles can coexist without duplicate `.palette` files.
