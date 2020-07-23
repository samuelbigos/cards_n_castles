extends Node2D
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
var _units = []
var _paths = {}
var _current_path
	
""" PUBLIC """

export var move_action_script : Resource
export var attack_action_script : Resource

###########
# METHODS #
###########

""" PRIVATE """

func _process(delta):
	update()

func _determine_attack(all_units, this_unit, this_data):
	if _did_move and not this_data.move_and_shoot:
		return null
		
	# sort units by priority
	_units.sort_custom(self, "_sort_attack_priority")
	var priority_unit = _units[0]
	
	# attempt to attack the first unit in range
	for i in range(0, _units.size()):
		var unit = _units[i]
		var range_to = Grid.cells_between(Grid.pos_to_grid_pos(this_unit.position), Grid.pos_to_grid_pos(unit.position))
		var this_range = this_data.attack_range
		var in_range = this_range >= range_to and range_to >= this_data.min_attack_range
		if in_range:
			var attack_action = attack_action_script.new()
			attack_action.target = unit
			attack_action.unit_data = this_data
			attack_action.attack_damage = this_data.damage
			if this_data.strong_vs.has(unit.get_unit_id()):
				attack_action.attack_damage = this_data.strong_damage
			
			_did_attack = true
			return attack_action
			
	return null
	
func _determine_move(all_units, this_unit, this_data):
	if _did_attack and not this_data.move_and_shoot:
		return null
		
	# sort units by priority
	_units.sort_custom(self, "_sort_move_priority")
	var priority_unit = _units[0]
	
	# attempt to move towards priority target.
	var priority_range = Grid.cells_between(Grid.pos_to_grid_pos(this_unit.position), Grid.pos_to_grid_pos(priority_unit.position))
	var in_range = this_data.attack_range >= priority_range
	if not in_range or not this_data.prefer_max_range:
		_current_path = _paths[priority_unit]
		
		var vector = Vector2()
		if _current_path.size() == 0: # even if no path we still want to attempt to move towards target.
			vector = Grid.pos_to_grid_pos(priority_unit.position) - Grid.pos_to_grid_pos(this_unit.position)
		else:
			var path_point = _current_path[1]
			var path_point_2d = Vector2(path_point.x, path_point.y)
			var this_pos = Grid.pos_to_grid_pos(this_unit.position)
			vector = path_point_2d - this_pos
			
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

func _sort_move_priority(a, b):
	var path_a = _paths[a]
	var path_b = _paths[b]
	#if _paths[b].size() == 0:
	#	return true
	#if _paths[a].size() == 0:
	#	return false
	if a.is_wall() and not b.is_wall():
		return false
	if b.is_wall() and not a.is_wall():
		return true	
	return path_a.size() < path_b.size()

func _sort_attack_priority(a, b):
	var path_a = _paths[a]
	var path_b = _paths[b]
	if a.is_wall():
		return false
	if b.is_wall():
		return true
	return path_a.size() < path_b.size()
	
func _draw():
	return
	var unit_paths = []
	for unit in _units:
		unit_paths.append(_paths[unit])
	
	for path in unit_paths:
		var last_node_pos = position
		for node in path:
			var pos = Grid.grid_pos_to_snapped_pos(Vector2(node.x, node.y)) - (global_position - position)
			
			var color = Color.aqua
			if _current_path == path:
				color = Color.red
				
			draw_circle(pos, 1.0, color)							
			draw_line(last_node_pos, pos, color)
			last_node_pos = pos
	
""" PUBLIC """

func reset(all_units, this_unit, this_data):
	_attack_count = this_data.attack_count
	_move_count = this_data.move_count
	_did_move = false
	_did_attack = false
	
func determine_actions(all_units, this_unit, this_data):
	# update the a* grid to take into account current unit positions.
	Grid.update_grid()
	
	# determine unit priority
	_units = []
	_paths = {}
	for unit in all_units:
		if unit.get_team() == this_unit.get_team():
			continue			
		if unit == null:
			continue			
		_paths[unit] = Grid.get_astar_path(this_unit.position, unit.position)			
		_units.append(unit)
		
	if _units.size() == 0:
		return null
			
	if _move_count > 0:
		var action = _determine_move(all_units, this_unit, this_data)
		if action != null:
			_move_count -= 1
			return action
			
	if _attack_count > 0:
		var action = _determine_attack(all_units, this_unit, this_data)
		if action != null:
			_attack_count -= 1
			return action

	return null
