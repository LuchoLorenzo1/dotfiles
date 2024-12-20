from libqtile import widget, qtile
from .theme import colors

def separator():
    return widget.Sep(
        linewidth=4,
        padding=14,
        background=colors["dark"],
        foreground=colors["color2"],
    )

def icon(fg="text", bg="dark", fontsize=16, text="?", app="alacritty"):
    return widget.TextBox(
        fontsize=fontsize,
        text=text,
        padding=3,
        mouse_callbacks={"Button1": lambda: qtile.cmd_spawn(app)},
    )


def workspaces():
    return [
        # separator(),
        widget.GroupBox(
            font="UbuntuMono Nerd Font",
            # background=colors['dark'],
            fontsize=19,
            margin_y=3,
            margin_x=0,
            padding_y=8,
            padding_x=5,
            borderwidth=1,
            active=colors["text"],
            inactive=colors["dark"],
            highlight_color=["00ff00", "0000ff"],
            rounded=True,
            highlight_method="block",
            urgent_alert_method="block",
            urgent_border=colors["grey"],
            this_current_screen_border=colors["color2"],
            this_screen_border=colors["color2"],
            other_current_screen_border=colors["dark"],
            other_screen_border=colors["dark"],
            disable_drag=True,
        ),
        # separator(),
        widget.WindowName(fontsize=14, padding=5),
        widget.Prompt(
            background=colors["dark"],
            prompt="",
        ),
    ]


primary_widgets = [
    *workspaces(),
    separator(),
    icon(
        bg="color4", text=" ", app="alacritty -e sudo pacman -Syu"
    ),
    widget.CheckUpdates(
        background=colors["dark"],
        colour_have_updates="ffffff",
        colour_no_updates="ffffff",
        distro="Arch",
        no_update_string="0",
        display_format="{updates}",
        update_interval=1800,
    ),
    separator(),
    icon(bg="color3",text='RAM'),
    widget.Memory(
        format='{MemUsed: .0f}{mm}',
        mouse_callbacks={'Button1': lambda: qtile.cmd_spawn("alacritty -e htop")},
    ),
    separator(),
    icon(bg="color3",text='CPU'),
    widget.CPU(
        format='{freq_current}GHz {load_percent}%',
        mouse_callbacks={'Button1': lambda: qtile.cmd_spawn("alacritty -e htop")},
    ),
    separator(),
    icon(bg="color3", text=" ", app="pavucontrol"),
    widget.PulseVolume(
        volume_app="pavucontrol",
        volume_up_command="pactl --set-sink-volume 0 +1%",
        volume_down_command="pactl --set-sink-volume 0 -1%",
        update_interval=0.01667,
    ),
    separator(),
    widget.Clock(format="%d/%m - %H:%M"),
    separator(),
    widget.KeyboardLayout(configured_keyboards=['us', 'es'], mouse_callbacks={'Button1': lambda: qtile.cmd_spawn("toggle_lang")},),
    separator(),
    widget.Systray(background=colors["dark"], padding=5),
]

widget_defaults = {
    "font": "UbuntuMono Nerd Font Bold",
    "fontsize": 14,
    "padding": 1,
    "background": colors["dark"],
}
extension_defaults = widget_defaults.copy()
