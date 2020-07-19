extends BaseAction
class_name ActionAttack
"""
Attack action.
"""

###########
# MEMBERS #
###########

""" PRIVATE """

var _started_attack = false
var _projectile = null

""" PUBLIC """

signal on_hit(action, attack_damage)

var target = null
var unit_data = null
var attack_damage = 0

###########
# METHODS #
###########

""" PRIVATE """

func _process_action(_delta):
	if not _started_attack:
		_projectile = unit_data.projectile.instance()
		_projectile.setup(_owner.position, target.position)
		_projectile.connect("on_target_reached", self, "_on_complete")
		add_child(_projectile)
		
		# hook up signal to tell target when it's hit
		connect("on_hit", target, "_on_ActionAttach_on_hit")
		
		_started_attack = true
		
func _on_complete():
	emit_signal("on_hit", self, attack_damage)
	disconnect("on_hit", target, "_on_ActionAttach_on_hit")
	_projectile.queue_free()
	._on_complete()
	
""" PUBLIC """
