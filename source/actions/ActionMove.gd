extends BaseAction
class_name ActionMove
"""
Move action.
"""

###########
# MEMBERS #
###########

""" PRIVATE """

var direction = Vector2()

""" PUBLIC """

var _started_move = false

###########
# METHODS #
###########

""" PRIVATE """

func _process_action(_delta):
	if not _started_move:
		var moved = _owner._move_to_grid_relative(direction)
		if moved:
			_owner.connect("on_movement_complete", self, "_on_complete")
			_started_move = true
		else:
			_on_complete()
			

""" PUBLIC """
