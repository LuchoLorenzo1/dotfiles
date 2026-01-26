from libqtile import layout
from libqtile.config import Match
from .theme import colors

layout_conf = {"border_focus": colors["focus"], "border_width": 2, "margin": 15}
max_conf = {"border_focus": colors["dark"], "border_width": 0, "margin": 0}

layouts = [
    layout.Max(**max_conf),
    layout.MonadTall(**layout_conf),
    # layout.Bsp(**layout_conf),
    # layout.MonadWide(**layout_conf),
    # layout.Matrix(columns=2, **layout_conf),
    # layout.RatioTile(**layout_conf),
    # layout.Columns(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]


floating_layout = layout.Floating(
    border_width=0,
    border_focus="#000000",
    border_normal="#000000",
)

# floating_layout = layout.Floating(
#     float_rules=[
#         *layout.Floating.default_float_rules,
#         Match(wm_class="confirmreset"),
#         Match(wm_class="makebranch"),
#         Match(wm_class="maketag"),
#         Match(wm_class="ssh-askpass"),
#         Match(title="branchdialog"),
#         Match(title="pinentry"),
#     ],
#     border_focus=colors["dark"],
# )
