---
name: ptyxis-palette-studio
description: Create and maintain image-derived Ptyxis terminal palettes in the user's unix-colour-palletes collection, with either a normal opaque profile or the reusable Glass Water transparency effect. Use when the user supplies a wallpaper and asks for a terminal palette, asks to make an existing palette translucent, or wants to manage and publish this palette collection.
---

# Ptyxis Palette Studio

Build readable Ptyxis palettes from the user's images and preserve each image/palette pairing in the existing collection.

Before changing files, read [references/local-workflow.md](references/local-workflow.md) for the maintained paths, palette format, and verification steps.

## Appearance Model

Treat the terminal appearance as three independent layers:

1. **Base palette:** foreground, background tint, cursor, titlebar, and 16 ANSI colors.
2. **Profile effect:** opacity and related Ptyxis profile settings.
3. **Wallpaper:** the unmodified source image visible behind a translucent window.

Normal mode uses the base palette at opacity `1.0`. Glass Water mode uses the same base palette at opacity `0.78`; it does not create or modify a second palette file. Keep both profiles available by labeling the glass profile `<PALETTE>-GLASS`.

`GLASS-WATER` has two related but distinct meanings in this collection:

- `GLASS-WATER.palette` is a standalone water-tinted base palette.
- `--glass` is the reusable opacity effect that can be applied to any base palette.

For example, `NEON-KIMONO --glass` means the unchanged `NEON-KIMONO` colors plus the Glass Water opacity effect. Do not create `NEON-KIMONO-GLASS.palette`.

## Choose The Mode

When the user supplies a new image, use their explicit choice of **normal** or **Glass Water** style. If they do not specify a mode, ask one short question before changing files: "Normal or Glass Water style?"

If the user requests both, create one base palette and activate both profile variants. Do not duplicate the palette or wallpaper.

## Create A Palette

- Inspect the image and derive a deliberate set of colors from its dominant shadows, subject colors, highlights, and small accents.
- Choose a concise uppercase hyphenated name that reflects the image.
- Prefer a dark or controlled midtone background with high-contrast foreground text. Preserve legibility when Glass Water mode reveals a bright or detailed wallpaper.
- Give ANSI colors distinct semantic roles; do not merely generate small variations of one hue.
- Preserve the source image exactly. Copy it without resizing, recompressing, or changing format.
- Store one `.palette` file in each maintained location and pair the raw image in the repository using the established naming convention.
- Update the collection README and wallpaper map without removing or reordering unrelated user content.

## Activate And Verify

Use the repository activation script:

```bash
./scripts/activate-palette.sh <PALETTE>
./scripts/activate-palette.sh <PALETTE> --glass
```

Normal and glass profiles must coexist. Verify the selected profile's `palette` and `opacity` through `gsettings`, verify all saved palette copies match, and verify the raw image dimensions and tracked repository entry.

Ptyxis does not provide a native per-profile background-image setting. Glass mode reveals the desktop wallpaper or windows behind Ptyxis through compositor transparency; do not claim that the image is embedded inside the terminal.

## Publish The Collection

For this established collection, commit and push the palette, raw image, documentation, and workflow changes together unless the user asks for local-only work. Preserve unrelated worktree changes. Report the palette name, selected mode, raw image resolution, commit ID, and current palette count.

Count `.palette` files, not profiles. A glass profile does not increase the palette count.
