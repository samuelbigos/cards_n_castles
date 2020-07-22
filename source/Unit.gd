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

const MOVE_SNAP_TIME = 0.3
const MOUSE_SNAP_TIME = 0.1
const DAMAGE_FLASH_TIME = 0.1
const MOVE_AUDIO_LOOP_TIME = 0.3

signal on_turn_over
signal on_movement_complete
signal on_death(unit)
signal on_picked(unit)
signal on_unpicked(unit)

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
var _colour
var _damage_flashing = false
var _damage_flash_timer = 0.0
var _hovered = false
var _total_snap_time

var _move_audio_playing = false
var _move_audio_loop_timer = 0.0

###########
# METHODS #
###########

""" PRIVATE """

func _ready():
	$Sprite.modulate = Globals.palette_pale
		
func _process(delta):
	if _sticky:
		_move_to_mouse(get_viewport().get_mouse_position())
		if Input.is_action_just_released("ui_select"):
			_sticky = false
			emit_signal("on_unpicked", self)
			
	if _snap_lerp_timer > 0.0:
		position = _lerp(_snap_lerp_from, _snap_lerp_to, _snap_lerp_timer / _total_snap_time)
		_snap_lerp_timer -= delta
		if _snap_lerp_timer <= 0.0:
			position = _snap_lerp_to
			emit_signal("on_movement_complete")
			$MoveAudio.stop()
			_move_audio_playing = false
			
	if _move_audio_playing:
		_move_audio_loop_timer -= delta
		if _move_audio_loop_timer < 0.0:
			$MoveAudio.play()
			_move_audio_loop_timer = MOVE_AUDIO_LOOP_TIME
		
	if _hovered or _sticky:
		$Selection.visible = true
	else:
		$Selection.visible = false			
			
	_damage_flash_timer -= delta
	if _damage_flash_timer < 0.0 and _damage_flashing:
		_damage_flash_timer = DAMAGE_FLASH_TIME
		_damage_flashing = false
		self.visible = true
		
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
		_snap_lerp_timer = MOVE_SNAP_TIME
		_total_snap_time = MOVE_SNAP_TIME
		_face_dir(pos)
		_fire_move_audio()
		return true
	else:
		return false
					
func _move_to_mouse(pos:Vector2):
	# adjust pos to snap to grid
	var mouse_grid_pos = Grid.pos_to_grid_pos(pos)
	var can_move = mouse_grid_pos != _mouse_grid_pos_last 
	can_move = can_move and Grid.get_at(mouse_grid_pos.x, mouse_grid_pos.y) == null
	can_move = can_move and Globals.is_over_deploy_zone(pos)
	
	if can_move:
		_snap_lerp_from = Grid.grid_pos_to_snapped_pos(_mouse_grid_pos_last)
		_snap_lerp_to = Grid.grid_pos_to_snapped_pos(mouse_grid_pos)
		_snap_lerp_timer = MOUSE_SNAP_TIME
		_total_snap_time = MOUSE_SNAP_TIME
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
	
func _fire_move_audio():
	_move_audio_playing = true
	_move_audio_loop_timer = MOVE_AUDIO_LOOP_TIME
	$MoveAudio.stop()
	$MoveAudio.seek(0)
	$MoveAudio.play(0)
	
# time between 0-1
func _lerp(from, to, time):
	return from + (to - from) * ease(1.0 - time, -3)
	
func _on_Area2D_mouse_entered():
	if _process_input:
		_hovered = true
		$Selection.modulate = Globals.palette_pale

func _on_Area2D_mouse_exited():
	if _process_input:
		_hovered = false

func _on_Area2D_input_event(_viewport, event, _shape_idx):
	if _process_input: # TODO: Move this input logic to Player.gd
		if event.is_action_pressed("ui_select"):
			_sticky = true
			emit_signal("on_picked", self)
			
func _on_BaseAction_on_action_complete(action):
	_state = State.DETERMINE_ACTION
	
func _on_ActionAttack_on_hit(action, attack_damage):
	_health -= attack_damage
	self.visible = false
	_damage_flashing = true
	_damage_flash_timer = DAMAGE_FLASH_TIME
	
	var rand_audio = _cached_data.hit_audio[Globals.rng.randi_range(0, _cached_data.hit_audio.size() - 1)]
	$HitAudio.stream = rand_audio
	#$HitAudio.play()
	
	_update_health()
	
func _face_dir(dir):
	if dir.x > 0:
		$Sprite.flip_h = false
		$SpriteAccent.flip_h = false
	else:
		$Sprite.flip_h = true
		$SpriteAccent.flip_h = true

""" PUBLIC """

func init_with_data(card_data, team, game):
	_cached_data = card_data.duplicate()
	_game = game
	if team == 0:
		_colour = Globals.palette_teal
	else:
		_colour = Globals.palette_brown
	
	$Sprite.texture = _cached_data.sprite
	$SpriteAccent.texture = _cached_data.sprite_accent
	$SpriteAccent.modulate = _colour
	for pip in $Health.get_children():
		pip.modulate = _colour
		
	_max_health = _cached_data.health
	_health = _cached_data.health
	for i in range(0, $Health.get_child_count()):
		if i < _max_health:
			$Health.get_child(i).visible = true
			
	connect("on_death", _game, "_on_Unit_on_death")
	connect("on_picked", _game, "_on_Unit_on_picked")
	connect("on_unpicked", _game, "_on_Unit_on_unpicked")
	
	_team = team
		
func set_grid_pos(pos):
	position = Grid.grid_pos_to_snapped_pos(pos)
	_mouse_grid_pos_last = pos
	if not Grid.has(self):
		Grid.add(pos.x, pos.y, self)
	else:
		Grid.move(self, pos.x, pos.y)
		
func set_being_dragged(pos):
	_sticky = true
	_process_input = true
	_mouse_grid_pos_last = pos
	set_grid_pos(pos)
	emit_signal("on_picked", self)

func get_initiative():
	return _cached_data.initiative

func get_team():
	return _team

func do_turn():
	_state = State.DETERMINE_ACTION
	$AI.reset(_game.get_all_units(), self, _cached_data)
	
func _fire_attack_audio(sfx):
	$AttackAudio.stream = sfx
	$AttackAudio.play()
	
func _fire_onhit_audio(sfx):
	$HitAudio.stream = sfx
	$HitAudio.play()
