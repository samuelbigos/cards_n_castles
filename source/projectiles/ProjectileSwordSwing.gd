extends BaseProjectile
class_name ProjectileSwordSwing
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
	$AnimatedSprite.modulate = Globals.palette_player
	
func _process(delta):
	pass
	
func _AnimatedSprite_on_animation_finished():
	emit_signal("on_target_reached")

""" PUBLIC """

func setup(from, to):	
	rotation = -atan2((from - to).x, (from - to).y)
	position = (from + to) * 0.5
	$AnimatedSprite.frame = 0
	$AnimatedSprite.play("default")
	$AnimatedSprite.connect("animation_finished", self, "_AnimatedSprite_on_animation_finished")
