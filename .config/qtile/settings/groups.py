from libqtile.config import Key, Group
from libqtile.command import lazy
from .keys import mod, keys

groups = [Group(i) for i in ("6", "7", "8", "9", "0")]
ext_keys = ["y", "u", "i", "o", "p"]

for i, group in enumerate(groups):
    actual_key = str(i + 1)
    keys.extend(
        [
            Key([mod], group.name, lazy.group[group.name].toscreen()),
            Key([mod, "shift"], group.name, lazy.window.togroup(group.name)),
            Key([mod], ext_keys[i], lazy.group[group.name].toscreen()),
            Key([mod, "shift"], ext_keys[i], lazy.window.togroup(group.name)),
        ]
    )
