-- Kanagawa Lotus
-- https://github.com/kanagawa-community/hyprland
local c = {
    bg = "rgb(f2ecbc)",
    bg_dark = "rgb(d5cea3)",
    bg_select = "rgb(e4d794)",
    fg = "rgb(545464)",
    fg_dim = "rgb(43436c)",
    accent = "rgb(4d699b)",
    accent2 = "rgb(624c83)",
    urgent = "rgb(e82424)",
}

hl.config({
    general = {
        col = {
            active_border = { colors = { c.accent, c.accent2 }, angle = 45 },
            inactive_border = c.bg_select,
            nogroup_border = c.bg_dark,
            nogroup_border_active = c.accent,
        },
    },
    group = {
        col = {
            border_active = c.accent,
            border_inactive = c.bg_select,
            border_locked_active = c.urgent,
            border_locked_inactive = c.bg_dark,
        },
        groupbar = {
            text_color = c.fg,
            text_color_inactive = c.fg_dim,
            col = {
                active = c.bg_select,
                inactive = c.bg_dark,
                locked_active = c.urgent,
                locked_inactive = c.bg_dark,
            },
        },
    },
    misc = {
        background_color = c.bg,
    },
})

return c
