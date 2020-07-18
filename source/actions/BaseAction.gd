extends Node
class_name BaseAction
"""
Base class for unit actions.
"""

###########
# MEMBERS #
###########

""" PRIVATE """

var _owner = null
var _processing = false

""" PUBLIC """

signal on_action_complete

###########
# METHODS #
###########

""" PRIVATE """

func _process(delta):
	if _processing:
		_process_action(delta)
		
func _process_action(_delta): # virtual
	pass
	
func _on_complete():
	emit_signal("on_action_complete", self)
	
""" PUBLIC """

func begin(owner):
	_processing = true
	_owner = owner
