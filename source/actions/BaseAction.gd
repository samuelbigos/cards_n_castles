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
var _fired = false

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
	if not _fired:
		emit_signal("on_action_complete", self)
		_fired = true
	
""" PUBLIC """

func begin(owner):
	_processing = true
	_owner = owner
