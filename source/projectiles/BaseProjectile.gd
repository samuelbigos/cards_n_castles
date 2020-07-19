extends Node2D
class_name BaseProjectile
"""
Is a projectile.
"""

###########
# MEMBERS #
###########

""" PRIVATE """

var _lerp_time = 0.0
var _lerp_timer = 0.0
var _lerp_to = Vector2()
var _lerp_from = Vector2()

""" PUBLIC """

const PROJECTILE_SPEED = 100.0

signal on_target_reached

###########
# METHODS #
###########

""" PRIVATE """

func _ready():
	pass
	
func _process(delta):
	if _lerp_timer > 0.0:
		position = _lerp(_lerp_from, _lerp_to, _lerp_timer / _lerp_time)
		_lerp_timer -= delta
		if _lerp_timer <= 0.0:
			position = _lerp_to
			emit_signal("on_target_reached")
			
func _lerp(from, to, time):
	return from + (to - from) * ease(1.0 - time, 0.3)

""" PUBLIC """

func setup(from, to):
	_lerp_time = (from - to).length() / PROJECTILE_SPEED
	_lerp_timer = _lerp_time
	_lerp_from = from
	_lerp_to = to
	rotation = -atan2((from - to).x, (from - to).y)
