from libqtile.config import Key, Group
from libqtile.lazy import lazy
from .keys import mod, keys

ext_keys = ["b", "y", "u", "i", "o", "p", "bracketleft", "bracketright", "backslash"]
groups = [Group(i) for i in ("b", "y", "u", "i", "o", "p", "1", "2", "3")]

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
