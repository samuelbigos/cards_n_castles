extends Node
"""
Singleton that handles playing music.
"""

###########
# MEMBERS #
###########

""" PRIVATE """

var _battle_tracks = []
var _menu_tracks = []
var _playing_battle = false
var _playing_menu = false
var _playing = null
var _enabled = true

""" PUBLIC """

###########
# METHODS #
###########

""" PRIVATE """

func _ready():
	for track in $Battle.get_children():
		_battle_tracks.append(track)
		
	for track in $Menu.get_children():
		_menu_tracks.append(track)
		
func _on_track_finished():
	if _playing_battle:
		play_battle()
	if _playing_menu:
		play_menu()
	
""" PUBLIC """

func is_playing():
	return _playing != null
	
func play_battle():
	stop_play()
	var index = Globals.rng.randi_range(0, _battle_tracks.size() - 1)
	_playing = _battle_tracks[index]
	_playing.connect("finished", self, "on_track_finished")
	_playing.play()
	_playing_battle = true
	
func play_menu(track = -1):
	stop_play()
	if track == -1:
		track = Globals.rng.randi_range(0, _menu_tracks.size() - 1)
	_playing = _menu_tracks[track]
	_playing.connect("finished", self, "on_track_finished")
	_playing.play()
	_playing_menu = true
	
func stop_play():
	if _playing:
		_playing.disconnect("finished", self, "on_track_finished")
		_playing.stop()
	_playing = null

func set_enabled(enabled):
	_enabled = enabled
	if _enabled:
		play_menu(1)
	else:
		stop_play()
		
func get_enabled():
	return _enabled
