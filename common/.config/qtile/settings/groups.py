from libqtile.config import Key, Group
from libqtile.lazy import lazy
from .keys import mod, keys

def go_to_group(name: str, monitor: int):
    def _inner(qtile):
        if monitor >= 0:
            qtile.focus_screen(monitor)
        qtile.groups_map[name].toscreen()
    return _inner

monitors = [1, 0, 2, 1, 0, 2, -1]
# monitors = [2, 0, 1, 2, 0, 1, -1]
groups = [Group(i) for i in ("u", "i", "o", "7", "8", "9", "p")]
for i, group in enumerate(groups):
    key = i
    keys.extend(
        [
            Key([mod], group.name, lazy.function(go_to_group(group.name, monitors[i])),),
            Key([mod, "shift"], group.name, lazy.window.togroup(group.name)),
        ]
    )
