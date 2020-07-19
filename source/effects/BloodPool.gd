extends Sprite
class_name BloodPool
"""
Randomised blood pool sprite shown when unit dies
"""

###########
# MEMBERS #
###########

""" PRIVATE """

var _rng = RandomNumberGenerator.new()

""" PUBLIC """

export var blood_images = []

###########
# METHODS #
###########

""" PRIVATE """

""" PUBLIC """

func _ready():
	_rng.randomize()
	var blood = _rng.randi_range(0, blood_images.size() - 1)
	texture = blood_images[blood]
	modulate = Globals.palette_brown
