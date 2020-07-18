extends Node2D
class_name Unit
"""
Base for a unit on the battlefield.
"""

###########
# MEMBERS #
###########

""" PRIVATE """

""" PUBLIC """

const SNAP_TIME = 0.25

signal on_turn_over
signal on_movement_complete

var _sticky = false
var _mouse_grid_pos_last = Vector2()
var _snap_lerp_timer = 0.0
var _snap_lerp_to = Vector2()
var _snap_lerp_from = Vector2()
var _process_input = false
var _team = -1
var _cached_data = null
var _processing_turn = false
var _processing_action = false
var _action_stack = []

###########
# METHODS #
###########

""" PRIVATE """

func _ready():
	$Sprite.modulate = Color("2e5266")
		
func _process(delta):
	if _sticky:
		_move_to_mouse(get_viewport().get_mouse_position())
		if Input.is_action_just_released("ui_select"):
			_sticky = false
			
	if _snap_lerp_timer > 0.0:
		position = _lerp(_snap_lerp_from, _snap_lerp_to, _snap_lerp_timer / SNAP_TIME)
		_snap_lerp_timer -= delta
		if _snap_lerp_timer <= 0.0:
			position = _snap_lerp_to
			emit_signal("on_movement_complete")
		
	if _processing_turn:
		if _action_stack.size() == 0:
			emit_signal("on_turn_over")
			_processing_turn = false
		else:
			# process the action stack
			if not _processing_action:
				var action_to_process = _action_stack[0]
				action_to_process.connect("on_action_complete", self, "_on_BaseAction_on_action_complete")
				action_to_process.begin(self)
				add_child(action_to_process)
				_processing_action = true		
			
func _move_to_grid_relative(pos:Vector2):
	var global_pos = _pos_to_grid_pos(position) + pos
	var moved = Grid.move(self, global_pos.x, global_pos.y)
	if moved:
		_snap_lerp_from = position
		_snap_lerp_to = _grid_pos_to_snapped_pos(global_pos)
		_snap_lerp_timer = SNAP_TIME
		return true
	else:
		return false
					
func _move_to_mouse(pos:Vector2):
	# adjust pos to snap to grid
	var mouse_grid_pos = _pos_to_grid_pos(pos)
	if mouse_grid_pos != _mouse_grid_pos_last and Grid.get_at(mouse_grid_pos.x, mouse_grid_pos.y) == null:
		_snap_lerp_from = _grid_pos_to_snapped_pos(_mouse_grid_pos_last)
		_snap_lerp_to = _grid_pos_to_snapped_pos(mouse_grid_pos)
		_snap_lerp_timer = SNAP_TIME
		Grid.move(self, mouse_grid_pos.x, mouse_grid_pos.y)
		
	_mouse_grid_pos_last = mouse_grid_pos
		
func _pos_to_snapped_pos(pos:Vector2):
	return _grid_pos_to_snapped_pos(_pos_to_grid_pos(pos))
	
func _grid_pos_to_snapped_pos(pos:Vector2):
	return pos * (Grid.cell_size + ((Vector2(1.0, 1.0) * Grid.cell_padding))) + Grid.cell_size * 0.5
		
func _pos_to_grid_pos(pos:Vector2):
	return Vector2(int(pos.x / (Grid.cell_size.x + Grid.cell_padding)),
					int(pos.y / (Grid.cell_size.y + Grid.cell_padding)))
	
func _in_hand():
	# 1st column is in hand for now.
	return _pos_to_snapped_pos(position).x == 0
	
# time between 0-1
func _lerp(from, to, time):
	return from + (to - from) * ease(1.0 - time, -3)
	
func _on_Area2D_mouse_entered():
	if _process_input:
		$Selection.visible = true

func _on_Area2D_mouse_exited():
	if _process_input:
		$Selection.visible = false

func _on_Area2D_input_event(_viewport, event, _shape_idx):
	if _process_input: # TODO: Move this input logic to Player.gd
		if event.is_action_pressed("ui_select"):
			_sticky = true
			
func _on_BaseAction_on_action_complete(action):
	_processing_action = false
	_action_stack.erase(action)
	action.queue_free()

""" PUBLIC """

func init_with_data(card_data, team):
	$Sprite.texture = card_data.sprite
	$SpriteBG.texture = card_data.sprite_bg
	_team = team
	_cached_data = card_data.duplicate()
		
func set_grid_pos(pos):
	position = _grid_pos_to_snapped_pos(pos)
	_mouse_grid_pos_last = pos
	if not Grid.has(self):
		Grid.add(pos.x, pos.y, self)
	else:
		Grid.move(self, pos.x, pos.y)

func get_initiative():
	return _cached_data.initiative

func do_turn():
	_processing_turn = true
	$AI.reset()
	_action_stack = $AI.determine_actions(self)
