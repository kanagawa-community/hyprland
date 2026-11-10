# Contributing to Kanagawa for Hyprland

Thanks for helping. This port follows the
[Kanagawa community contributing guide](https://github.com/kanagawa-community/.github/blob/main/.github/CONTRIBUTING.md),
which explains conventional commits, the checks every pull request runs, and how
changes are reviewed. This page covers only what is specific to this port.

## Where to report what

- Problems with the theme in Hyprland, such as wrong colors, poor
  contrast, or a missing variant, belong in this repository's
  [issue tracker](https://github.com/kanagawa-community/hyprland/issues).
- Problems in Hyprland itself belong with its maintainers, not here. Start
  from the [application's page](https://hypr.land/).
- Changes to the colors themselves belong in the
  [shared palette](https://github.com/kanagawa-community/.github/blob/main/docs/PALETTE.md),
  not in this port. Open an issue in the
  [.github repository](https://github.com/kanagawa-community/.github/issues)
  so every port stays in step.

## Colors

Take colors from the shared [palette](https://github.com/kanagawa-community/.github/blob/main/docs/PALETTE.md)
and follow the [style guide](https://github.com/kanagawa-community/.github/blob/main/docs/STYLE-GUIDE.md).
Do not sample colors from screenshots or add new ones. Every change must work in
Wave, Dragon, and Lotus.

To read the colors from a script, use the machine-readable
[palette.json](https://raw.githubusercontent.com/kanagawa-community/.github/main/palette.json).

## Working on this port

`scripts/generate.py` writes the themes in `themes/` from the shared palette by
role. Do not edit a color value in a theme file. To change a theme:

1. Change the role mapping in `scripts/generate.py`.
2. Run `scripts/generate.py`.
3. Commit its output.

CI fails if a committed theme differs from the generator output. To try a change,
load the theme from a test file with `Hyprland --verify-config -c <file>`.

The images in `assets/` are screenshots of a real Hyprland desktop. Hyprland
needs a GPU, so it cannot run in the headless sway that the other ports use.
After changing a theme, on a machine or a throwaway VM with Hyprland, grim and
foot, run this from a text console (not from a desktop session):

```sh
scripts/capture-in-session.sh
```

Then build the showcase and the social preview from the
[.github repository](https://github.com/kanagawa-community/.github):

```sh
scripts/finish-previews.sh Hyprland ../hyprland
```

Commit the new images. See the
[preview standard](https://github.com/kanagawa-community/.github/blob/main/docs/PREVIEWS.md#capturing-application-windows)
for the rest.
