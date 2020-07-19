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

const PLAYER_TEAM_ID = 0

export var starting_hand = []

###########
# METHODS #
###########

""" PRIVATE """

func _ready():
	pass
	
func _on_Game_state_change(_from, to):
	match to:
		Globals.State.DEPLOY:
			for unit in _units:
				unit._process_input = true
		Globals.State.BATTLE:
			for unit in _units:
				unit._process_input = false
				
func on_Unit_on_death(unit):
	_units.erase(unit)
	
""" PUBLIC """

func setup(game):
	_game = game
	var current_pos = 0
	for card in starting_hand:
		var card_data = _game.get_card_database().get_card_by_id(card)
		var unit = _game.unit_scene.instance()
		unit.init_with_data(card_data, PLAYER_TEAM_ID, _game)
		unit.set_grid_pos(Globals.BENCH_AREA_POS + Vector2(0, current_pos))
		unit.connect("on_death", self, "on_Unit_on_death")
		add_child(unit)
		_units.append(unit)
		current_pos += 1

func get_units():
	return _units
