# from libqtile import hook
# from libqtile.command import lazy
from settings.keys import mod, keys
from settings.groups import groups
from settings.layouts import layouts, floating_layout

# , floating_layout
from settings.widgets import widget_defaults

# , extension_defaults
from settings.screens import screens
from settings.mouse import mouse
from settings.path import qtile_path

# from os import path
# import subprocess


# @hook.subscribe.startup
# def autostart():
#     lazy.hide_bar("bottom")
#     lazy.hide_show_bar("top")


main = None
dgroups_key_binder = None
dgroups_app_rules = []
follow_mouse_focus = True
bring_front_click = False
cursor_warp = True
auto_fullscreen = True
focus_on_window_activation = "urgent"
wmname = "LG3D"
