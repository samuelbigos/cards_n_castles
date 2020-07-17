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

const SNAP_TIME = 0.15

var _sticky = false
var _mouse_snapped_pos_last = Vector2()
var _snap_lerp_timer = 0.0
var _snap_lerp_to = Vector2()
var _snap_lerp_from = Vector2()

###########
# METHODS #
###########

""" PRIVATE """

func _ready():
	$Sprite.modulate = Color("2e5266")
	
	
func _process(delta):
	if _sticky:
		_move_and_snap(get_viewport().get_mouse_position())
		if Input.is_action_just_released("ui_select"):
			_sticky = false
			
	if _snap_lerp_timer > 0.0:
		position = _lerp(_snap_lerp_from, _snap_lerp_to, _snap_lerp_timer / SNAP_TIME)
		_snap_lerp_timer -= delta
			
			
func _move_and_snap(pos):
	# adjust pos to snap to grid
	var mouse_snapped_pos = _pos_to_snapped_pos(pos)
	if mouse_snapped_pos != _mouse_snapped_pos_last:
		_snap_lerp_from = _mouse_snapped_pos_last
		_snap_lerp_to = mouse_snapped_pos
		_snap_lerp_timer = SNAP_TIME
		
	_mouse_snapped_pos_last = mouse_snapped_pos
		

func _pos_to_snapped_pos(pos):
	var snapped_pos = Vector2()
	snapped_pos.x = int(pos.x / (PixelGrid.cell_size.x + PixelGrid.cell_padding))
	snapped_pos.y = int(pos.y / (PixelGrid.cell_size.y + PixelGrid.cell_padding))
	return _grid_pos_to_snapped_pos(snapped_pos)
	
	
func _grid_pos_to_snapped_pos(pos):
	var snapped_pos = Vector2()
	snapped_pos = pos * (PixelGrid.cell_size + ((Vector2(1.0, 1.0) * PixelGrid.cell_padding)))
	snapped_pos += PixelGrid.cell_size * 0.5
	return snapped_pos
	

func _in_hand():
	# 1st column is in hand for now.
	return _pos_to_snapped_pos(position).x == 0
	

# time between 0-1
func _lerp(from, to, time):
	return from + (to - from) * ease(1.0 - time, -3)
	

func _on_Area2D_mouse_entered():
	$Selection.visible = true


func _on_Area2D_mouse_exited():
	$Selection.visible = false


func _on_Area2D_input_event(viewport, event, shape_idx):
	if Input.is_action_pressed("ui_select"):
		_sticky = true

""" PUBLIC """

func init_with_data(card_data):
	$Sprite.texture = card_data.sprite
	
	
func set_grid_pos(pos):
	position = _grid_pos_to_snapped_pos(pos)
	_mouse_snapped_pos_last = position
