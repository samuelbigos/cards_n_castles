extends Node
class_name AI
"""
Processes unit UI/behaviours.
"""

###########
# MEMBERS #
###########

""" PRIVATE """

var _attack_count = 0
var _move_count = 0
var _did_move = false
var _did_attack = false

""" PUBLIC """

export var move_action_script : Resource
export var attack_action_script : Resource

###########
# METHODS #
###########

""" PRIVATE """

func _determine_attack(all_units, this_unit, this_data):
	if _did_move and not this_data.move_and_shoot:
		return null
		
	for unit in all_units:
		if unit.get_team() == this_unit.get_team():
			continue
		
		var range_to = Grid.cells_between(Grid.pos_to_grid_pos(this_unit.position), Grid.pos_to_grid_pos(unit.position))
		var this_range = this_data.attack_range
		var in_range = this_range >= range_to and range_to >= this_data.min_attack_range
		if in_range: # TODO: attack highest priority in range rather than first in range
			var attack_action = attack_action_script.new()
			attack_action.target = unit
			attack_action.unit_data = this_data
			attack_action.attack_damage = this_data.damage
			_did_attack = true
			return attack_action
			
	return null
	
func _determine_move(all_units, this_unit, this_data):
	if _did_attack and not this_data.move_and_shoot:
		return null
		
	var closest_unit = null
	var closest_range = 99
	for unit in all_units:
		if unit.get_team() == this_unit.get_team():
			continue
		
		var range_to = Grid.cells_between(Grid.pos_to_grid_pos(this_unit.position), Grid.pos_to_grid_pos(unit.position))
		if range_to < closest_range:
			closest_range = range_to
			closest_unit = unit
	
	# if no enemies remain, just return a move with no direction.
	if closest_unit == null:
		var move_action = move_action_script.new()
		move_action.direction = Vector2(0, 0)
		_did_move = true
		return move_action
	
	var in_range = this_data.attack_range >= closest_range
	if not in_range or not this_data.prefer_max_range:
		var path_point = Grid.get_astar_path(this_unit.position, closest_unit.position)
		var vector = Grid.pos_to_grid_pos(path_point) - Grid.pos_to_grid_pos(this_unit.position)
		var move_dir = Vector2()
		if abs(vector.x) > abs(vector.y):
			if vector.x > 0: move_dir.x += 1
			else: move_dir.x -= 1
		else:
			if vector.y > 0: move_dir.y += 1
			else: move_dir.y -= 1
			
		var move_action = move_action_script.new()
		move_action.direction = move_dir
		_did_move = true
		return move_action
		
	return null

""" PUBLIC """

func reset(all_units, this_unit, this_data):
	_attack_count = this_data.attack_count
	_move_count = this_data.move_count
	_did_move = false
	_did_attack = false
	
func determine_actions(all_units, this_unit, this_data):
	# update the a* grid to take into account current unit positions.
	Grid.update_grid()
	
	if _attack_count > 0:
		var action = _determine_attack(all_units, this_unit, this_data)
		if action != null:
			_attack_count -= 1
			return action
			
	if _move_count > 0:
		var action = _determine_move(all_units, this_unit, this_data)
		if action != null:
			_move_count -= 1
			return action

	return null
