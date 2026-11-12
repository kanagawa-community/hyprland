#!/usr/bin/env python3
"""Write themes/kanagawa-<variant>.lua from the shared palette.

Usage: scripts/generate.py [path/to/palette.json]   (default: ../.github/palette.json)
"""
import json
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
VARIANTS = ["wave", "dragon", "lotus"]


def roles(variant):
    """Map each role to its hex color; a role missing from the palette raises KeyError later."""
    return {role: c["hex"] for c in variant["colors"].values() for role in c["usage"]}

# Color name -> palette role. The theme returns these colors, so other config
# can use them after it loads the theme.
COLORS = {
    "bg": "ui.bg",
    "bg_dark": "ui.bg_m3",
    "bg_select": "ui.bg_p2",
    "fg": "ui.fg",
    "fg_dim": "ui.fg_dim",
    "accent": "syn.fun",
    "accent2": "syn.keyword",
    "urgent": "diag.error",
}

LUA = """-- Kanagawa {name}
-- https://github.com/kanagawa-community/hyprland
local c = {{
{colors}
}}

hl.config({{
    general = {{
        col = {{
            active_border = {{ colors = {{ c.accent, c.accent2 }}, angle = 45 }},
            inactive_border = c.bg_select,
            nogroup_border = c.bg_dark,
            nogroup_border_active = c.accent,
        }},
    }},
    group = {{
        col = {{
            border_active = c.accent,
            border_inactive = c.bg_select,
            border_locked_active = c.urgent,
            border_locked_inactive = c.bg_dark,
        }},
        groupbar = {{
            text_color = c.fg,
            text_color_inactive = c.fg_dim,
            col = {{
                active = c.bg_select,
                inactive = c.bg_dark,
                locked_active = c.urgent,
                locked_inactive = c.bg_dark,
            }},
        }},
    }},
    misc = {{
        background_color = c.bg,
    }},
}})

return c
"""


def theme(variant, colors):
    lines = "\n".join(f'    {k} = "rgb({colors[r][1:]})",' for k, r in COLORS.items())
    return LUA.format(name=variant.capitalize(), colors=lines)


def main():
    path = Path(sys.argv[1]) if len(sys.argv) > 1 else ROOT.parent / ".github" / "palette.json"
    variants = json.loads(path.read_text())["variants"]
    for v in VARIANTS:
        out = ROOT / "themes" / f"kanagawa-{v}.lua"
        out.parent.mkdir(exist_ok=True)
        out.write_text(theme(v, roles(variants[v])))
        print(out.relative_to(ROOT))


if __name__ == "__main__":
    main()
