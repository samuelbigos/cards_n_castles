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

signal on_card_activated(card_data)
signal on_card_picked(card_data)
signal on_card_unpicked(card_data)

const HOVER_TWEEN_DISTANCE = 30.0
const HOVER_TWEEN_TIME = 0.2

###########
# METHODS #
###########

""" PRIVATE """

func _process(delta):
	if _sticky:
		$Sprite.position = get_local_mouse_position()
		
	if Input.is_action_just_released("ui_select"):
		_sticky = false
		emit_signal("on_card_unpicked", self)
		_reset_pos()
		
	if _sticky and Globals.is_over_deploy_zone(get_global_mouse_position()):
		spawn_unit()
		queue_free()
		
func _reset_pos():
	$Sprite.position = Vector2(0.0, 0.0)
	$Sprite/Area2D.position = Vector2(0.0, 0.0)
	$Sprite.z_index = 0
	$Tween.stop_all()

func _on_Area2D_mouse_entered():
	if not _sticky and _picking_enabled:
		$Sprite.z_index = 1
		$Tween.interpolate_property($Sprite, "position", Vector2(0.0, 0.0), 
			Vector2(0.0, -HOVER_TWEEN_DISTANCE), HOVER_TWEEN_TIME, Tween.TRANS_CIRC, Tween.EASE_OUT)
		$Tween.start()

func _on_Area2D_mouse_exited():
	if not _sticky and _picking_enabled:
		_reset_pos()
		$Tween.interpolate_property($Sprite, "position", Vector2(0.0, -HOVER_TWEEN_DISTANCE), 
			Vector2(0.0, 0.0), HOVER_TWEEN_TIME, Tween.TRANS_CIRC, Tween.EASE_OUT)
		$Tween.start()

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("ui_select") and _picking_enabled:
		_sticky = true
		emit_signal("on_card_picked", self)
		_reset_pos()

""" PUBLIC """

func setup(card):
	$Sprite.texture = card.card_sprite
	_card_data = card
	var collision_shape = $Sprite/Area2D/CollisionShape2D
	var shape = RectangleShape2D.new()
	shape.extents = $Sprite.get_rect().size * 0.5
	shape.extents.x *= 0.5
	collision_shape.shape = shape
	
func spawn_unit():
	emit_signal("on_card_activated", _card_data)

func get_width():
	return $Sprite.get_rect().size.x
	
func set_picking_enabled(enabled):
	_picking_enabled = enabled
	
func get_sprite_pos():
	return $Sprite.position
