extends Node
class_name Player
"""
Stores player state.
"""

###########
# MEMBERS #
###########

""" PRIVATE """

export var starting_hand = []

""" PUBLIC """

var _game = null
var _units = []

###########
# METHODS #
###########

""" PRIVATE """

func _ready():
	pass

""" PUBLIC """

func setup(game):
	_game = game
	var current_pos = 1
	for card in starting_hand:
		var card_data = _game.get_card_database().get_card_by_id(card)
		var unit = _game.unit_scene.instance()
		unit.init_with_data(card_data)
		unit.set_grid_pos(Vector2(0, current_pos))
		add_child(unit)
		current_pos += 1
