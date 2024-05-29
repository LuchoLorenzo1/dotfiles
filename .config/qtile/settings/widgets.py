from libqtile import widget, qtile
from .theme import colors

# Get the icons at https://www.nerdfonts.com/cheat-sheet (you need a Nerd Font)


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
    ),  # Icon: nf-fa-download
    widget.CheckUpdates(
        background=colors["dark"],
        colour_have_updates="ffffff",
        colour_no_updates="ffffff",
        distro="Arch_checkupdates",
        # no_update_string="0",
        display_format="{updates}",
        update_interval=1800,
    ),
    separator(),
    # icon(bg="color3", text=" "),  # Icon: nf-fa-feed
    # widget.Net(
    #     # interface='wlp2s0',
    #     format="{down}↓↑{up}",
    # ),
    # separator(),
    # icon(bg="color3",text='', app='alacritty -e htop'),
    # widget.Memory(
    #     format='{MemUsed: .0f}{mm}',
    #     mouse_callbacks={'Button1': lambda: qtile.cmd_spawn("alacritty -e htop")},
    # ),
    # separator(),
    # icon(bg="color3",text=' ', app='alacritty -e htop'),
    # widget.CPU(
    #     format='{freq_current}GHz {load_percent}%',
    #     mouse_callbacks={'Button1': lambda: qtile.cmd_spawn("alacritty -e htop")},
    # ),
    # separator(),
    # icon(bg="color3",text=' ',app='alacritty -e firefox https://www.google.com/search?channel=trow5&client=firefox-b-d&q=clima+martinez'),
    # widget.OpenWeather(
    #     format='{location_city}: {main_temp}°{units_temperature} {humidity}%',
    #     location='Martínez, AR',
    #     # weather_symbols=symbols,
    # ),
    #
    # separator(),
    # icon(bg="color3",text='阮 ', app='spotify'),
    # widget.Mpris2(
    #     name='spotify',
    #     objname="org.mpris.MediaPlayer2.spotify",
    #     display_metadata=['xesam:title', 'xesam:artist'],
    #     scroll_chars=None,
    #     stop_pause_text='',
    #     mouse_callbacks={'Button1': lambda: qtile.cmd_spawn('spotify')},
    # ),
    # icon(bg="color3",text='玲', app="dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Previous"),
    # icon(bg="color3",text=' ', app="dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause"),
    # icon(bg="color3",text='怜', app="dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Next"),
    # separator(),
    icon(bg="color3", text=" ", app="pavucontrol"),
    widget.PulseVolume(
        volume_app="pavucontrol",
        volume_up_command="pactl --set-sink-volume 0 +1%",
        volume_down_command="pactl --set-sink-volume 0 -1%",
        update_interval=0.01667,
    ),
    separator(),
    # widget.Pomodoro(
    #     prefix_inactive=' ',
    #     prefix_paused='  ',
    #     color_active=colors['focus'],
    #     color_inactive=colors['light'],
    #     color_break=colors['active'],
    # ),
    # separator(),
    # icon(bg="color1", fontsize=17, text=' '),
    widget.Clock(format="%d/%m - %H:%M"),
    separator(),
    widget.Systray(background=colors["dark"], padding=5),
]

# secondary_widgets = [
#     *workspaces(),
#     separator(),
#     separator(),
#     widget.CurrentLayoutIcon(scale=0.65),
#     widget.CurrentLayout(padding=5),
#     separator(),
#     widget.Clock(format="%d/%m - %H:%M "),
#     separator(),
# ]

widget_defaults = {
    "font": "UbuntuMono Nerd Font Bold",
    "fontsize": 14,
    "padding": 1,
    "background": colors["dark"],
}
extension_defaults = widget_defaults.copy()
