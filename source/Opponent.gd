extends Node2D
class_name Opponent
"""
Manages opponent units.
"""

###########
# MEMBERS #
###########

""" PRIVATE """

var _game = null
var _units = []

""" PUBLIC """

signal on_all_units_dead

const OPPONENT_START = Vector2(9, 2)
const OPPONENT_TEAM_ID = 1

export var level_script : Resource

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
	var non_wall_units = 0
	for unit in _units:
		if unit._cached_data.attack_count > 0:
			non_wall_units += 1
	if non_wall_units == 0:
		emit_signal("on_all_units_dead")

""" PUBLIC """

func setup(game):
	_game = game
	var current_level = PlayerData.get_current_level()
	var opponent_layout = Levels.levels[current_level]["opponent"]
	for x in range(0, opponent_layout.size()):
		for y in range(0, opponent_layout[x].size()):
			# note x and y flipped here because 'level' is defined backwards for readability.
			# fix when implementing proper level structure.
			if opponent_layout[x][y] == null:
				continue
				
			var card_data = _game.get_card_database().get_card_by_id(opponent_layout[x][y])
			var unit = _game.unit_scene.instance()
			unit.init_with_data(card_data, OPPONENT_TEAM_ID, _game)
			unit.set_grid_pos(Vector2(OPPONENT_START.x + x, OPPONENT_START.y + y))
			unit.connect("on_death", self, "_on_Unit_on_death")
			unit._face_dir(Vector2(-1, 0))
			add_child(unit)
			_units.append(unit)

func get_units():
	return _units
