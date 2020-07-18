extends Node
class_name Game
"""
Base scene for all game components and state management.
"""

###########
# MEMBERS #
###########

""" PRIVATE """

var _state = Globals.State.NONE

""" PUBLIC """

export var unit_scene : PackedScene = null

signal state_change(from, to)

###########
# METHODS #
###########

""" PRIVATE """

func _ready():
	$Player.setup(self)
	$Opponent.setup(self)
	change_state(Globals.State.DEPLOY)
	
	
func _on_Game_state_change(from, to):
	pass
	
""" PUBLIC """

func get_card_database():
	return $DatabaseCards
	
	
func change_state(to):
	emit_signal("state_change", _state, to)
	_state = to
	
	
func get_state():
	return _state
