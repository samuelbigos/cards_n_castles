extends Node2D
class_name Unit
"""
Base for a unit on the battlefield.
"""

enum State {
	IDLE,
	DETERMINE_ACTION,
	PROCESS_ACTION
}

###########
# MEMBERS #
###########

""" PRIVATE """

""" PUBLIC """

const SNAP_TIME = 0.25

signal on_turn_over
signal on_movement_complete
signal on_death(unit)

var _game = null
var _sticky = false
var _mouse_grid_pos_last = Vector2()
var _snap_lerp_timer = 0.0
var _snap_lerp_to = Vector2()
var _snap_lerp_from = Vector2()
var _process_input = false
var _team = -1
var _cached_data = null
var _state = State.IDLE
var _action = null
var _health = 0
var _max_health = 0

###########
# METHODS #
###########

""" PRIVATE """

func _ready():
	$Sprite.modulate = Color("2e5266")
	for pip in $Health.get_children():
		pip.modulate = Color("d91f30")
		
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
		
	match _state:
		State.IDLE:
			pass
			
		State.DETERMINE_ACTION:
			if _action:
				_action.queue_free()
				
			_action = $AI.determine_actions(_game.get_all_units(), self, _cached_data)
			if _action == null:
				emit_signal("on_turn_over")
				_state = State.IDLE
			else:
				_action.connect("on_action_complete", self, "_on_BaseAction_on_action_complete")
				_action.begin(self)
				add_child(_action)
				_state = State.PROCESS_ACTION
			
		State.PROCESS_ACTION:
			pass
			
			
func _move_to_grid_relative(pos:Vector2):
	var global_pos = Grid.pos_to_grid_pos(position) + pos
	var moved = Grid.move(self, global_pos.x, global_pos.y)
	if moved:
		_snap_lerp_from = position
		_snap_lerp_to = Grid.grid_pos_to_snapped_pos(global_pos)
		_snap_lerp_timer = SNAP_TIME
		return true
	else:
		return false
					
func _move_to_mouse(pos:Vector2):
	# adjust pos to snap to grid
	var mouse_grid_pos = Grid.pos_to_grid_pos(pos)
	if mouse_grid_pos != _mouse_grid_pos_last and Grid.get_at(mouse_grid_pos.x, mouse_grid_pos.y) == null:
		_snap_lerp_from = Grid.grid_pos_to_snapped_pos(_mouse_grid_pos_last)
		_snap_lerp_to = Grid.grid_pos_to_snapped_pos(mouse_grid_pos)
		_snap_lerp_timer = SNAP_TIME
		Grid.move(self, mouse_grid_pos.x, mouse_grid_pos.y)
		
	_mouse_grid_pos_last = mouse_grid_pos
	
func _in_hand():
	# 1st column is in hand for now.
	return Grid.pos_to_snapped_pos(position).x == 0
	
func _update_health():
	for i in range(0, $Health.get_child_count()):
		if i < _health:
			$Health.get_child(i).visible = true
		else:
			$Health.get_child(i).visible = false
	if _health <= 0:
		_die()
		
func _die():
	# TODO: particles
	emit_signal("on_death", self)
	queue_free()
	
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
	_state = State.DETERMINE_ACTION
	
func _on_ActionAttach_on_hit(action, attack_damage):
	_health -= attack_damage
	_update_health()

""" PUBLIC """

func init_with_data(card_data, team, game):
	_cached_data = card_data.duplicate()
	_game = game
	$Sprite.texture = _cached_data.sprite
	$SpriteBG.texture = _cached_data.sprite_bg
	_max_health = _cached_data.health
	_health = _cached_data.health
	for i in range(0, $Health.get_child_count()):
		if i < _max_health:
			$Health.get_child(i).visible = true
		
	_team = team
		
func set_grid_pos(pos):
	position = Grid.grid_pos_to_snapped_pos(pos)
	_mouse_grid_pos_last = pos
	if not Grid.has(self):
		Grid.add(pos.x, pos.y, self)
	else:
		Grid.move(self, pos.x, pos.y)

func get_initiative():
	return _cached_data.initiative

func get_team():
	return _team

func do_turn():
	_state = State.DETERMINE_ACTION
	$AI.reset(_game.get_all_units(), self, _cached_data)
