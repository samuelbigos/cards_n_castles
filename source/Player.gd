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

signal on_all_units_dead

const PLAYER_TEAM_ID = 0

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
				
func _on_Unit_on_death(unit):
	_units.erase(unit)
	if _units.size() == 0:
		emit_signal("on_all_units_dead")
	
func _spawn_unit(pos, card_data):
	var unit = _game.unit_scene.instance()
	unit.init_with_data(card_data, PLAYER_TEAM_ID, _game)
	unit.set_being_dragged(Grid.pos_to_grid_pos(pos))
	unit.connect("on_death", self, "_on_Unit_on_death")
	add_child(unit)
	_units.append(unit)
	
func _on_Card_on_card_unpicked(card_data, card):
	if Globals.is_over_deploy_zone(get_global_mouse_position()):
		_spawn_unit(get_global_mouse_position(), card_data)
		card.queue_free()
	
""" PUBLIC """

func setup(game):
	_game = game
	var card_data_list = []
	for card in PlayerData.get_starting_hand():
		var card_data = _game.get_card_database().get_card_by_id(card)
		card_data_list.append(card_data)
		
	$CanvasLayer/PlayerHand.setup(card_data_list, self)

func get_units():
	return _units
