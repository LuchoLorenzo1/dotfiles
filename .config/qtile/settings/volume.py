last_playing = 'spotify'

def playpause(qtile):
    global last_playing
    #if qtile.widgetMap['clementine'].is_playing() or last_playing == 'clementine':
        #qtile.cmd_spawn("clementine --play-pause")
        #last_playing = 'clementine'
    #if qtile.widgetMap['spotify'].is_playing or last_playing == 'spotify':
    qtile.cmd_spawn("dbus -send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause")
    last_playing = 'spotify'

def next_prev(state):
    def f(qtile):
        #if qtile.widgetMap['clementine'].is_playing():
        #qtile.cmd_spawn("clementine --%s" % state)
        #if qtile.widgetMap['spotify'].is_playing:
        cmd = "Next" if state == "next" else "Previous"
        qtile.cmd_spawn("dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.%s" % cmd)
    return f

