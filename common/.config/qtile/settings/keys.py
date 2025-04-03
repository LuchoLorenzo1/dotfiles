from libqtile.config import Key
from libqtile.lazy import lazy

lazy.hide_show_bar("bottom")
mod = "mod4"

keys = [
    Key(key[0], key[1], *key[2:])
    for key in [
        # ------------ Window Configs ------------
        # Switch between windows in current stack pane
        ([mod], "j", lazy.layout.down()),
        ([mod], "k", lazy.layout.up()),
        ([mod], "h", lazy.layout.left()),
        ([mod], "l", lazy.layout.right()),
        # Change window sizes (MonadTall)
        ([mod, "shift"], "l", lazy.layout.grow()),
        ([mod, "shift"], "h", lazy.layout.shrink()),
        # Toggle floating
        ([mod, "shift"], "f", lazy.window.toggle_floating()),
        # Move windows up or down in current stack
        ([mod, "shift"], "j", lazy.layout.shuffle_down()),
        ([mod, "shift"], "k", lazy.layout.shuffle_up()),
        # Toggle between different layouts as defined below
        ([mod], "m", lazy.next_layout()),
        ([mod], "Tab", lazy.next_layout()),
        ([mod, "shift"], "Tab", lazy.prev_layout()),
        # Kill window
        ([mod], "BackSpace", lazy.window.kill()),

        # Switch focus of monitors
        # ([mod], "period", lazy.next_screen()),
        # ([mod], "comma", lazy.prev_screen()),
        # Restart Qtile

        ([mod, "control"], "r", lazy.restart()),
        ([mod, "control"], "q", lazy.shutdown()),

        ([mod], "t", lazy.spawn("rofi -combi-modi window,drun,ssh -show combi -show-icons")),
        ([mod], "v", lazy.spawn("toggle_output")),

        ([mod], "a", lazy.hide_show_bar("top"), lazy.hide_show_bar("bottom")),
        # ------------ App Configs ------------

        # ([mod], "e", lazy.spawn('toggle_lang')),
        ([mod], "e", lazy.widget["keyboardlayout"].next_keyboard()),

        ([mod], "Return", lazy.spawn("alacritty")),


        # ([mod], "b", lazy.group["7"].toscreen(), lazy.spawn("chromium")),
        # ([mod], "p", lazy.group["0"].toscreen(), lazy.spawn("discord")),
        # ([mod], "s", lazy.group["0"].toscreen(), lazy.spawn("spotify-launcher")),

        ([mod, "shift"], "s", lazy.spawn("flameshot gui")),

        # ------------ Hardware Configs ------------
        (
            [],
            "XF86AudioPrev",
            lazy.spawn(
                "dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Previous"
            ),
        ),
        (
            [],
            "XF86AudioPlay",
            lazy.spawn(
                "dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause"
            ),
        ),
        (
            [],
            "XF86AudioNext",
            lazy.spawn(
                "dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Next"
            ),
        ),
        ([], "XF86AudioMute", lazy.spawn("pactl set-sink-mute 0 toggle")),
        ([], "XF86AudioLowerVolume", lazy.spawn("pactl set-sink-volume 0 -2%")),
        ([], "XF86AudioRaiseVolume", lazy.spawn("pactl set-sink-volume 0 +2%")),
    ]
]
