extends Node
class_name AI
"""
Processes unit UI/behaviours.
"""

###########
# MEMBERS #
###########

""" PRIVATE """

""" PUBLIC """

export var move_action_script : Resource
export var attack_action_script : Resource

###########
# METHODS #
###########

""" PRIVATE """

""" PUBLIC """

func reset():
	pass
	
func determine_actions(unit):
	var actions = []
	if unit._cached_data.can_move:
		var move_action = move_action_script.new()
		move_action.direction = Vector2(1, 0)
		actions.append(move_action)
	return actions
