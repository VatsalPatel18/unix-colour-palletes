# Local Ptyxis Palette Workflow

## Maintained Locations

- Repository: `/home/prime/Documents/github/unix-colour-palletes`
- Repository palettes: `/home/prime/Documents/github/unix-colour-palletes/palettes`
- Repository wallpapers: `/home/prime/Documents/github/unix-colour-palletes/wallpapers`
- Activation script: `/home/prime/Documents/github/unix-colour-palletes/scripts/activate-palette.sh`
- Active Ptyxis palettes: `/home/prime/.local/share/org.gnome.Ptyxis/palettes`
- Backup collection: `/home/prime/colour pallete`

The repository remote is `git@github.com:VatsalPatel18/unix-colour-palletes.git` on branch `main`.

## Naming

Use an uppercase hyphenated palette name such as `NEON-KIMONO`.

- Palette file: `palettes/<PALETTE>.palette`
- Raw wallpaper: `wallpapers/<PALETTE>__<original-filename>`
- Normal profile label: `<PALETTE>`
- Glass profile label: `<PALETTE>-GLASS`

The wallpaper filename records the pairing. Do not alter the raw image bytes.

## Ptyxis Palette Format

Create a UTF-8 text file with this complete shape:

```ini
[Palette]
Name=<PALETTE>
Foreground=#RRGGBB
Background=#RRGGBB
Cursor=#RRGGBB
CursorForeground=#RRGGBB
TitlebarBackground=#RRGGBB
TitlebarForeground=#RRGGBB
BellForeground=#RRGGBB
BellBackground=#RRGGBB
SuperuserForeground=#RRGGBB
SuperuserBackground=#RRGGBB
RemoteForeground=#RRGGBB
RemoteBackground=#RRGGBB
Color0=#RRGGBB
Color1=#RRGGBB
Color2=#RRGGBB
Color3=#RRGGBB
Color4=#RRGGBB
Color5=#RRGGBB
Color6=#RRGGBB
Color7=#RRGGBB
Color8=#RRGGBB
Color9=#RRGGBB
Color10=#RRGGBB
Color11=#RRGGBB
Color12=#RRGGBB
Color13=#RRGGBB
Color14=#RRGGBB
Color15=#RRGGBB
```

Keep the foreground readable against the solid background and against likely bright wallpaper areas at 78% opacity.

## Required Copies And Documentation

Save identical palette content to:

1. `palettes/<PALETTE>.palette` in the repository.
2. `/home/prime/.local/share/org.gnome.Ptyxis/palettes/<PALETTE>.palette`.
3. `/home/prime/colour pallete/<PALETTE>.palette`.

Add the palette to both collection README files. Add image-derived palettes to the repository's `wallpaper-palette-map.md` and copy the original image into `wallpapers/` with the paired name.

## Activation

Run from the repository root:

```bash
./scripts/activate-palette.sh <PALETTE>
./scripts/activate-palette.sh <PALETTE> --glass
```

The script uses opacity `1.0` for normal mode and `0.78` for Glass Water mode. `GLASS-WATER` itself defaults to `0.78`.

## Verification

- Run `bash -n scripts/activate-palette.sh` after editing the script.
- Compare the repository, active, and backup palette files with `cmp -s`.
- Check the wallpaper with `file` or `identify` and ensure the original dimensions are preserved.
- Verify the active profile's `palette` and `opacity` via `gsettings`.
- Run `git diff --check` before committing.
- Confirm `git status --short --branch` is clean after pushing.

If `ptyxis --import-palette` reports that a palette already exists, do not create a duplicate. Verify or replace only that exact palette file, then activate it with the repository script.
