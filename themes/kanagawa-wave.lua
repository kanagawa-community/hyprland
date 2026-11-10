-- Kanagawa Wave
-- https://github.com/kanagawa-community/hyprland
local c = {
    bg = "rgb(1f1f28)",
    bg_dark = "rgb(16161d)",
    bg_select = "rgb(363646)",
    fg = "rgb(dcd7ba)",
    fg_dim = "rgb(c8c093)",
    accent = "rgb(7e9cd8)",
    accent2 = "rgb(957fb8)",
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
