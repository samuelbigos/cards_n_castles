extends Node2D
class_name Opponent
"""
Manages opponent units.
"""

const opponent_start = Vector2(10, 4)
const level = [[null, null, null, null, null],
				[null, "maa", null, "archer", null],
				[null, "maa", null, null, null],
				[null, "maa", null, "archer", null],
				[null, null, null, null, null]]

###########
# MEMBERS #
###########

""" PRIVATE """

var _game = null
var _units = []

""" PUBLIC """

const OPPONENT_TEAM_ID = 1

###########
# METHODS #
###########

""" PRIVATE """

func _ready():
	pass			
			
func _on_Game_state_change(_from, _to):
	pass # Replace with function body.
	
func _on_Unit_on_death(unit):
	_units.erase(unit)

""" PUBLIC """

func setup(game):
	_game = game
	for x in range(0, level.size()):
		for y in range(0, level[x].size()):
			# note x and y flipped here because 'level' is defined backwards for readability.
			# fix when implementing proper level structure.
			if level[y][x] == null:
				continue
				
			var card_data = _game.get_card_database().get_card_by_id(level[y][x])
			var unit = _game.unit_scene.instance()
			unit.init_with_data(card_data, OPPONENT_TEAM_ID, _game)
			unit.set_grid_pos(Vector2(opponent_start.x + x, opponent_start.y + y))
			unit.connect("on_death", self, "_on_Unit_on_death")
			unit._face_dir(Vector2(-1, 0))
			add_child(unit)
			_units.append(unit)

func get_units():
	return _units
