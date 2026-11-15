# Independent workspaces per display

Link both `aerospace.toml` and `display-workspaces.sh` into
`${XDG_CONFIG_HOME:-$HOME/.config}/aerospace/`. Bindings run the helper with Bash.

AeroSpace has a global workspace namespace. HDR 4K owns workspaces 1–10;
SDQHD owns 11–20. The helper translates local numbers using the focused
display, including when its current workspace is empty.

- Option + 1–9 / 0 switches only the focused display to local workspace 1–10.
- Option + Shift + 1–9 / 0 moves the focused window to that local workspace
  on the same display and follows it. The other display stays unchanged.
- Option + Tab toggles the previous workspace selected through this helper
  on the focused display. History is independent for each display.
- Ctrl + Option + H/J/K/L navigates windows across displays.
- Ctrl + Option + M changes monitor focus.
- Ctrl + Option + Tab retains global previous-window focus behavior.

For example, Option + 5 selects workspace 5 on HDR 4K or workspace 15 on
SDQHD. No workspace synchronization or summoning is used. Option + Shift +
Tab remains unbound because workspaces are pinned to their displays.

Mapping uses exact display names from `aerospace list-monitors`; an unknown
display is rejected. This configuration targets the two named displays.
Local history lives in `${XDG_CACHE_HOME:-$HOME/.cache}/aerospace-displays/`
and tracks only workspace changes made through this helper.

References:
- https://nikitabobko.github.io/AeroSpace/guide#multiple-monitors
- https://nikitabobko.github.io/AeroSpace/guide#assign-workspaces-to-monitors
