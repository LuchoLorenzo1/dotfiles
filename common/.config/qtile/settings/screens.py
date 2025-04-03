from libqtile.config import Screen
from libqtile import bar
from .widgets import primary_widgets, secondary_widgets, tertiary_widgets

def status_bar(widgets):
    return bar.Bar(widgets, border_width=0, size=24, opacity=1, margin=0)

screens = [Screen(bottom=status_bar(primary_widgets)), Screen(bottom=status_bar(secondary_widgets)), Screen(bottom=status_bar(tertiary_widgets))]
