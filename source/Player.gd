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
	var non_wall_units = 0
	for unit in _units:
		if unit._cached_data.attack_count > 0:
			non_wall_units += 1
	if non_wall_units == 0:
		emit_signal("on_all_units_dead")
	
func _spawn_unit(pos, card_data, dragged = true):
	var unit = _game.unit_scene.instance()
	unit.init_with_data(card_data, PLAYER_TEAM_ID, _game)
	if dragged:
		unit.set_being_dragged(Grid.pos_to_grid_pos(pos))
	unit.connect("on_death", self, "_on_Unit_on_death")
	add_child(unit)
	_units.append(unit)
	return unit
	
func _on_Card_on_card_unpicked(card_data, card):
	if Globals.is_over_deploy_zone(get_global_mouse_position()):
		var unit = _spawn_unit(get_global_mouse_position(), card_data)
		unit.connect("on_unit_to_card", $CanvasLayer/PlayerHand, "_on_Unit_on_unit_to_card")
		unit.connect("on_unit_to_card", self, "_on_Unit_on_unit_to_card")
		card.queue_free()
		
func _on_Card_on_card_force_deploy(card_data, card, pos):
	if Globals.is_over_deploy_zone(pos):
		var unit = _spawn_unit(pos, card_data, false)
		card.queue_free()
	
func _on_Unit_on_unit_to_card(unit, card_data):
	_units.erase(unit)
	
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
