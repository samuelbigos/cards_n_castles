extends BaseProjectile
class_name ProjectileArrow
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
	$Sprite.modulate = Globals.palette_player
	
func _process(delta):
	pass

""" PUBLIC """

func setup(from, to):
	.setup(from, to)
