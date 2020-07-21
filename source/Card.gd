extends Node2D
class_name Card
"""
On-screen card representation.
"""

###########
# MEMBERS #
###########

""" PRIVATE """

var _sticky = false
var _card_data = null
var _picking_enabled = true

""" PUBLIC """

signal on_card_picked(card_data, card)
signal on_card_unpicked(card_data, card)

const HOVER_TWEEN_TIME = 0.2

var hover_tween_distance = 30.0

###########
# METHODS #
###########

""" PRIVATE """

func _process(delta):
	if _sticky:
		$Sprite.position = get_local_mouse_position()
		
		if Input.is_action_just_released("ui_select"):
			_sticky = false
			emit_signal("on_card_unpicked", _card_data, self)
			_reset_pos()
		
func _reset_pos():
	$Sprite.position = Vector2(0.0, 0.0)
	$Area2D.position = Vector2(0.0, 0.0)
	$Sprite.z_index = 0
	$Tween.stop_all()

func _on_Area2D_mouse_entered():
	if not _sticky and _picking_enabled:
		$Sprite.z_index = 1
		$Tween.interpolate_property($Sprite, "position", Vector2(0.0, 0.0), 
			Vector2(0.0, -hover_tween_distance), HOVER_TWEEN_TIME, Tween.TRANS_CIRC, Tween.EASE_OUT)
		$Tween.start()

func _on_Area2D_mouse_exited():
	if not _sticky and _picking_enabled:
		_reset_pos()
		$Tween.interpolate_property($Sprite, "position", Vector2(0.0, -hover_tween_distance), 
			Vector2(0.0, 0.0), HOVER_TWEEN_TIME, Tween.TRANS_CIRC, Tween.EASE_OUT)
		$Tween.start()

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("ui_select") and _picking_enabled:
		_sticky = true
		emit_signal("on_card_picked", self)
		_reset_pos()

""" PUBLIC """

func setup(card, in_hand = true):
	$Sprite.texture = card.card_sprite
	_card_data = card
	var collision_shape = $Area2D/CollisionShape2D
	var shape = RectangleShape2D.new()
	shape.extents = $Sprite.get_rect().size * 0.5
	if in_hand:
		shape.extents.x *= 0.6
	collision_shape.shape = shape

func get_width():
	return $Sprite.get_rect().size.x
	
func set_picking_enabled(enabled):
	_picking_enabled = enabled
	
func get_sprite_pos():
	return $Sprite.position
