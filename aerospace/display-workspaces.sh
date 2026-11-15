#!/bin/bash
# Select a numbered workspace on the focused display only.
set -euo pipefail

state_dir="${XDG_CACHE_HOME:-$HOME/.cache}/aerospace-displays"
mkdir -p "$state_dir"
for ((attempt = 0; attempt < 100; attempt++)); do
  if mkdir "$state_dir/lock" 2>/dev/null; then
    trap 'rmdir "$state_dir/lock"' EXIT
    break
  fi
  sleep 0.02
done
if ((attempt == 100)); then
  exit 1
fi

action="${1:-switch}"
number="${2:-}"
IFS='|' read -r current monitor < <(
  aerospace list-workspaces --focused --format '%{workspace}|%{monitor-name}'
)
case "$monitor" in
  'LG HDR 4K') offset=0 ;;
  'LG SDQHD') offset=10 ;;
  *) printf 'No workspace mapping for display: %s\n' "$monitor" >&2; exit 1 ;;
esac
history="$state_dir/previous-$offset"
if [[ "$action" == back ]]; then
  [[ -f "$history" ]] || exit 0
  read -r number < "$history"
fi
case "$number" in
  [1-9]|10) ;;
  *) exit 2 ;;
esac
target=$((number + offset))

case "$action" in
  switch|back) aerospace workspace "$target" ;;
  move)
    window_id=$(aerospace list-windows --focused --format '%{window-id}')
    [[ "$window_id" =~ ^[0-9]+$ ]] || exit 0
    aerospace move-node-to-workspace --focus-follows-window --window-id "$window_id" "$target"
    ;;
  *) exit 2 ;;
esac
if [[ "$current" =~ ^[0-9]+$ ]] && ((current > offset && current <= offset + 10 && current != target)); then
  printf '%s\n' "$((current - offset))" > "$history"
fi
