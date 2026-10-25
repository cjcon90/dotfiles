# Sway rice: SwayFX, Dracula, islands

Date: 2026-10-25
Branch: `rice` (dotfiles), plus a small change in `arch-setup`

## Goal

Make the sway desktop look riced and polished, Dracula only, on two machines:

- N151CU (Arch laptop): build and verify everything here.
- Work laptop (Fedora 44, ultrawide monitor): the user checks out `rice`, installs packages by hand, and runs `stow`.

All or nothing. If it doesn't work on Fedora, the `rice` branch is deleted. If it works, it's merged into `master`.

## Constraints

- Dracula palette only (`#282a36` bg, `#21222c` darker bg, `#44475a` current line, `#f8f8f2` fg, `#6272a4` comment, `#8be9fd` cyan, `#50fa7b` green, `#ffb86c` orange, `#ff79c6` pink, `#bd93f9` purple, `#ff5555` red, `#f1fa8c` yellow).
- Every new tool must be installable on both Arch and Fedora 44.
- Existing keybindings, gaps, workspaces, display profiles, be quiet! keyboard setup and the clock module (always-on date, Proton Calendar click, interactive calendar) stay as they are, unless listed below.
- No Fedora setup script. Fedora gets a copy-paste command list (below).
- Never push. Commits are local only.

## Components

### 1. SwayFX (replaces sway)

New labelled `### Effects (SwayFX)` section in `.config/sway/config`:

- `corner_radius 12`
- Shadows on all windows, soft. Slightly stronger on floating windows.
- `default_dim_inactive 0.15`, replacing the transparency script.
- `layer_effects` with blur for the waybar, rofi, swaync and swayosd layer namespaces.

Deleted: `.config/sway/inactive_windows_transparency.py` and its `exec` line. It is the only user of `python-i3ipc`.

Risk to check during implementation: the waybar layer surface spans the whole screen width, so blur would also cover the gaps between islands. Use `blur_ignore_transparent` on that layer so only the islands are blurred. Set the islands' rounded corners in waybar CSS, not with `corner_radius` in `layer_effects`, which rounds the whole surface. Confirm the actual layer namespace names with `swaymsg -t get_tree` / `layer_effects` testing.

### 2. Waybar: floating islands, compact labels

- `window#waybar` background transparent.
- `.modules-left`, `.modules-center`, `.modules-right` each styled as an island: `rgba(40,42,54,.82)` background, 12px radius, 2px `#6272a4` border at ~70% opacity. The centre (clock) island uses a `#bd93f9` border.
- Left island: workspaces + media. Centre: clock. Right: status modules.
- Compact labels:
  - network wifi: strength only (e.g. `󰖩 93%`), SSID in the tooltip.
  - bluetooth connected: battery only (e.g. `󰂱 30%`), device alias in the tooltip.
- New `custom/notification` module at the end of the right island: bell icon from `swaync-client -swb`. Click toggles the panel, right-click toggles do-not-disturb.
- Fix the existing height warning (requested 38, modules need 52) by setting the height and padding so they agree.
- Module colours unchanged.

Accepted trade-off: gaps between islands differ per screen (laptop 1920px: ~397px left / ~262px right with a song playing). No per-output bar configs.

### 3. Rofi: refined list

Same layout as today (centred list), restyled in `.config/rofi/dracula.rasi`:

- Window: 12px radius, see-through `#282a36` (blurred by SwayFX), 2px `#6272a4` border.
- Search box: `#21222c` background (replaces the Nord colour `#2e3440`), rounded.
- Selected row: `#44475a` background, pink border, rounded.
- Matches highlighted green, as today.

Applies to every rofi use: launcher (`$menu`), clipboard (`$mod+p`), wifi menu, wifi password prompt.

### 4. Lock screen: swaylock-effects (replaces swaylock)

New `.config/swaylock/config` (read automatically by swaylock):

- Screenshot of each output, blurred and dimmed: `screenshots`, `effect-blur=7x5`, `effect-vignette=0.5:0.5`.
- Clock (time + date) inside the indicator ring, always shown.
- Ring colours: idle `#bd93f9`, typing highlight `#ff79c6`, verifying `#8be9fd`, wrong `#ff5555`. Inside `#282a36` semi-transparent, text `#f8f8f2`.
- Short fade-in.

`$lock_cmd` becomes `swaylock -f`. Deleted: `.config/sway/swaylock-blur.sh`. `swayidle` and `$mod+Ctrl+l` keep using `$lock_cmd`.

### 5. Notifications: swaync (replaces mako)

New `.config/swaync/config.json` and `.config/swaync/style.css`:

- Popups top-right, rounded, see-through, 2px border.
- Border colour by urgency, as in today's mako config: low `#6272a4`, normal `#ff79c6`, critical `#ff5555`, Spotify `#50fa7b`. Timeouts: low 3s, normal 5s, critical never.
- Panel (control centre): slides in from the right, notification history, do-not-disturb toggle.

Sway changes:

- `exec /usr/bin/mako` becomes `exec swaync`.
- `$mod+n` (was `makoctl dismiss`) becomes `swaync-client -t -sw` (toggle panel).
- `$mod+Shift+n` (was `makoctl restore`) becomes `swaync-client -d -sw` (toggle do-not-disturb). History now lives in the panel.

Deleted: `.config/mako/config`.

### 6. Volume / brightness popup: swayosd

- `exec swayosd-server` in sway config.
- Volume keys use `swayosd-client --output-volume` instead of `wpctl`, keeping the current 2% step, the 100% cap and `--locked`. Mute likewise.
- Laptop brightness keys use `swayosd-client --brightness` instead of `brightnessctl`, keeping the 5% step and the waybar refresh signal (`pkill -RTMIN+8 -x waybar`).
- Shift+volume keys (playerctl next/prev/play-pause) unchanged.
- Styling in `.config/swayosd/style.css`: rounded pill near the bottom, see-through `#282a36`, cyan for volume, orange for brightness.
- The Dell's DDC brightness (waybar `custom/brightness` scroll) is unchanged. swayosd can't do DDC.

Check exact client flags against the installed swayosd version.

### 7. Screenshots: swappy

- `.local/bin/screenshot.sh`: `grim - | swappy -f -`
- `.local/bin/screenshot_select.sh`: `grim -g "$(slurp)" - | swappy -f -`
- New `.config/swappy/config`: `save_dir=$HOME/Pictures/screenshots`, `save_filename_format=%Y%m%d-%H%M%S.png`.

No keybinding changes: `Print`/`Shift+Print` and the be quiet! `M1`/`Shift+M1` already call these scripts. Behaviour change (accepted): nothing is saved until you save (`Ctrl+S`) or copy in swappy.

### Unchanged / dropped

- Wallpaper stays `dracula-kraken.png` via `output * bg`. awww dropped: nothing to fade between.
- autotiling and satty: not in scope.

## arch-setup changes (Arch only)

In `setup.sh`:

- Packages: add `swayfx`, `swaylock-effects` (both AUR, replacing `sway` and `swaylock`), `swaync`, `swayosd`, `swappy`. Remove `mako`, `python-i3ipc`, `sway`, `swaylock`.
- New step: symlink `~/.claude/CLAUDE.md` -> `~/.dotfiles/CLAUDE.md`.

## Fedora 44 commands (work laptop, by hand)

```bash
sudo dnf copr enable mochaa/swayfx
sudo dnf copr enable eddsalkield/swaylock-effects
sudo dnf copr enable celestelove/SwayOSD
sudo dnf swap sway swayfx
sudo dnf swap swaylock swaylock-effects
sudo dnf install SwayNotificationCenter swayosd swappy
sudo dnf remove mako
cd ~/.dotfiles && git fetch && git switch rice && stow -R -t ~ .
ln -sf ~/.dotfiles/CLAUDE.md ~/.claude/CLAUDE.md
```

Log out and back in afterwards. The COPRs have Fedora 44 build targets, but a successful current build isn't confirmed. If `dnf swap sway swayfx` fails, that is the signal to abandon.

## Verification (on N151CU)

- `sway -C` passes with the new config.
- Waybar config parses as JSON. Waybar starts with no errors or height warning.
- Screenshot each bar (`grim -o <output>`) and compare with the approved mockups: islands, compact labels, bell.
- `notify-send` at low, normal and critical urgency shows the right border colours. `$mod+n` opens the panel, `$mod+Shift+n` toggles do-not-disturb.
- Volume up/down/mute and laptop brightness keys show the popup and change the level as before.
- Lock with `$mod+Ctrl+l`: blur, clock, ring states, unlock works.
- Print / Shift+Print open swappy, and saving writes `~/Pictures/screenshots/YYYYMMDD-HHMMSS.png`.
- Rofi launcher, clipboard and wifi menu render with the new theme.

## Rollback

- Dotfiles: `git switch master && stow -R -t ~ .`
- Packages (Arch): reinstall `sway swaylock mako python-i3ipc`, which replaces swayfx and swaylock-effects.
