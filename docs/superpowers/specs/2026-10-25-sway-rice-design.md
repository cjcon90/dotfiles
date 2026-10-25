# Sway rice: SwayFX, Dracula

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
- Focused window: purple `#bd93f9` border with a soft pink glow (`shadow_color #ff79c666`, radius 25, no offset). Inactive windows keep a dark shadow.
- Blur on, with a light frosted look (`blur_noise 0.02`, `blur_brightness 0.9`, `blur_saturation 1.2`).
- `inactive_windows_transparency.py` stays, run with `-o 0.45`, so unfocused windows show the blurred wallpaper. SwayFX has no built-in inactive opacity, only dimming.
- Gaps raised to inner 14, outer 6 (20px to the screen edge).
- `layer_effects` with blur for the waybar, rofi, swaync and swayosd layer namespaces.

Changed 2026-10-25 after seeing it live: dimming alone looked flatter than the old transparency, so the script came back.

`layer_effects` takes its effect list as one quoted string (`layer_effects "waybar" "blur enable; blur_ignore_transparent enable"`). Unquoted, sway splits at `;` and only the first effect applies. `blur_ignore_transparent` keeps the transparent margins around waybar sharp. Rounded corners for waybar come from its CSS.

### 2. Waybar: refined full bar, compact labels

Changed 2026-10-25 after seeing islands on the real screen: the user prefers one full-width band.

- `window#waybar`: `rgba(40,42,54,.82)` background (blurred by SwayFX), 2px `#bd93f9` border at ~70% opacity to match the focused window, 12px radius. Side margins 20px and bottom 14px, lined up with the window gaps.
- Compact labels:
  - network wifi: strength only (e.g. `󰖩 93%`), SSID in the tooltip.
  - bluetooth connected: battery only (e.g. `󰂱 30%`), device alias in the tooltip.
- New `custom/notification` module at the end of `modules-right`: bell icon from `swaync-client -swb`. Click toggles the panel, right-click toggles do-not-disturb.
- Fix the existing height warning (requested 38, modules need 52) by removing the fixed height.
- Module colours unchanged.

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

- Packages: add `swayfx`, `swaylock-effects` (both AUR, replacing `sway` and `swaylock`), `swaync`, `swayosd`, `swappy`. Remove `mako`, `sway`, `swaylock`.
- New step: symlink `~/.claude/CLAUDE.md` -> `~/.dotfiles/CLAUDE.md`.

## Fedora 44 commands (work laptop, by hand)

```bash
sudo dnf copr enable mochaa/swayfx
sudo dnf copr enable eddsalkield/swaylock-effects
sudo dnf copr enable celestelove/SwayOSD
sudo dnf swap sway swayfx
sudo dnf swap swaylock swaylock-effects
sudo dnf install SwayNotificationCenter swayosd swappy python3-i3ipc
sudo dnf remove mako
cd ~/.dotfiles && git fetch && git switch rice && stow -R -t ~ .
ln -sf ~/.dotfiles/CLAUDE.md ~/.claude/CLAUDE.md
```

Log out and back in afterwards. The COPRs have Fedora 44 build targets, but a successful current build isn't confirmed. If `dnf swap sway swayfx` fails, that is the signal to abandon.

## Verification (on N151CU)

- `sway -C` passes with the new config.
- Waybar config parses as JSON. Waybar starts with no errors or height warning.
- Screenshot each bar (`grim -o <output>`) and check: rounded full-width bar, compact labels, bell.
- `notify-send` at low, normal and critical urgency shows the right border colours. `$mod+n` opens the panel, `$mod+Shift+n` toggles do-not-disturb.
- Volume up/down/mute and laptop brightness keys show the popup and change the level as before.
- Lock with `$mod+Ctrl+l`: blur, clock, ring states, unlock works.
- Print / Shift+Print open swappy, and saving writes `~/Pictures/screenshots/YYYYMMDD-HHMMSS.png`.
- Rofi launcher, clipboard and wifi menu render with the new theme.

## Rollback

- Dotfiles: `git switch master && stow -R -t ~ .`
- Packages (Arch): reinstall `sway swaylock mako`, which replaces swayfx and swaylock-effects.
