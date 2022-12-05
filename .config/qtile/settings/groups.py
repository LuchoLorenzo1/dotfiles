from libqtile.config import Key, Group
from libqtile.command import lazy
from .keys import mod, keys

groups = [Group(i) for i in ("6", "7", "8", "9", "0")]

for i, group in enumerate(groups):
    actual_key = str(i + 1)
    keys.extend(
        [
            # Switch to workspace N
            Key([mod], group.name, lazy.group[group.name].toscreen()),
            # Send window to workspace N
            Key([mod, "shift"], group.name, lazy.window.togroup(group.name)),
        ]
    )
