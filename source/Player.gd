extends Node2D
class_name Player
"""
Stores player state.
"""

###########
# MEMBERS #
###########

""" PRIVATE """

var _game = null
var _units = []

""" PUBLIC """

const DEPLOY_RECT_POS = Vector2(1, 1)
const DEPLOY_RECT_SIZE = Vector2(5, 12)

export var starting_hand = []

###########
# METHODS #
###########

""" PRIVATE """

func _ready():
	pass
	
	
func _draw():
	var rect = Rect2(DEPLOY_RECT_POS * Grid.grid_size, DEPLOY_RECT_SIZE * Grid.grid_size)
	draw_rect(rect, Color("000000"), false)
	
	
func _on_Game_state_change(from, to):
	match to:
		Globals.State.DEPLOY:
			for unit in _units:
				unit._process_input = true
		Globals.State.BATTLE:
			for unit in _units:
				unit._process_input = false
	

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
		_units.append(unit)
		current_pos += 1
