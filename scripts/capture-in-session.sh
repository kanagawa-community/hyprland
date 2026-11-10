#!/usr/bin/env bash
# Take assets/screenshots/{wave,dragon,lotus}.png from a real Hyprland. Hyprland
# needs a GPU, so it cannot run in the headless sway of capture-windows.sh. Run
# this from a text console (not from a desktop session) on a machine or VM with
# Hyprland, grim and foot. A throwaway VM with virtio-vga-gl works. For each
# variant it starts Hyprland with the theme and two terminals, captures the
# screen, and exits. Then run, from the .github repository:
#   scripts/finish-previews.sh Hyprland <port-dir>
# A whole desktop gets no window frame.
#
# Usage: scripts/capture-in-session.sh
set -u
root="$(cd "$(dirname "$(readlink -f "$0")")/.." && pwd)"
logs="$(mktemp -d)"
mkdir -p "$root/assets/screenshots"
# Do not stop a session that is in use: on a real machine that loses work.
if pgrep -x Hyprland >/dev/null; then
  echo "Hyprland is running. Exit it, then run this from a text console." >&2
  exit 1
fi
# A lock that no process holds is stale and blocks the display: remove it and
# its socket. A lock that a running compositor holds stays.
for lock in "$XDG_RUNTIME_DIR"/wayland-*.lock; do
  [[ -e $lock ]] || continue
  if flock -n "$lock" true; then rm -f "$lock" "${lock%.lock}"; fi
done
for v in wave dragon lotus; do
  cfg=$(mktemp --suffix=.lua)
  cat >"$cfg" <<EOF
local c = dofile("$root/themes/kanagawa-$v.lua")
hl.config({
    general = { border_size = 3, gaps_in = 8, gaps_out = 16 },
    decoration = { rounding = 8 },
    misc = { disable_hyprland_logo = true, disable_splash_rendering = true },
})
local function hex(s) return s:match("rgb%((%x+)%)") end
local foot = "foot -o colors-dark.background=" .. hex(c.bg) .. " -o colors-dark.foreground=" .. hex(c.fg)
    .. " -o colors-light.background=" .. hex(c.bg) .. " -o colors-light.foreground=" .. hex(c.fg)
-- Commands start before the socket exists and inherit an empty WAYLAND_DISPLAY,
-- so each one waits, then takes the newest socket.
local wl = "sleep 1; export WAYLAND_DISPLAY=\$(ls -t \$XDG_RUNTIME_DIR | grep -m1 -E '^wayland-[0-9]+\$'); "
hl.exec_cmd(wl .. foot .. " less $root/themes/kanagawa-$v.lua")
hl.exec_cmd(wl .. "sleep 1; " .. foot .. " less $root/scripts/capture-in-session.sh")
hl.exec_cmd(wl .. "sleep 5; grim $root/assets/screenshots/$v.png >$logs/grim-$v.log 2>&1; hyprctl dispatch 'hl.dsp.exit()'")
EOF
  # A hard limit: a stalled run cannot keep the keyboard.
  LESS='' LESSOPEN='' timeout -k 5 30 start-hyprland -- -c "$cfg" >"$logs/hyprland-$v.log" 2>&1 || true
  rm -f "$cfg"
  ls -la "$root/assets/screenshots/$v.png" || echo "no $v.png: see $logs"
done
