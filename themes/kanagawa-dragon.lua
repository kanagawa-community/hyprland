-- Kanagawa Dragon
-- https://github.com/kanagawa-community/hyprland
local c = {
    bg = "rgb(181616)",
    bg_dark = "rgb(0d0c0c)",
    bg_select = "rgb(393836)",
    fg = "rgb(c5c9c5)",
    fg_dim = "rgb(c8c093)",
    accent = "rgb(8ba4b0)",
    accent2 = "rgb(8992a7)",
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
