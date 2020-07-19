extends BaseProjectile
class_name ProjectileMango
"""
Is a projectile.
"""

###########
# MEMBERS #
###########

""" PRIVATE """

""" PUBLIC """

###########
# METHODS #
###########

""" PRIVATE """

func _ready():
	$AnimatedSprite.modulate = Globals.palette_pale
	
func _process(delta):
	pass

""" PUBLIC """

func setup(from, to):
	_lerp_time = (from - to).length() / PROJECTILE_SPEED
	_lerp_timer = _lerp_time
	_lerp_from = from
	_lerp_to = to
	rotation = -atan2((from - to).x, (from - to).y)
	
	$AnimatedSprite.frame = 0
	$AnimatedSprite.play("default")
