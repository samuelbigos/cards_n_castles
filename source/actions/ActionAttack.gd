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
var _mango_projectiles = []
var _mango_splash_vectors = [Vector2(0.0, 0.0),
							Vector2(1.0, 0.0),
							Vector2(0.0, 1.0),
							Vector2(-1.0, 0.0),
							Vector2(0.0, -1.0)]
var _mango_targets = []

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
		if unit_data.mango_attack:
			_do_mango_attack()
		else:
			_projectile = unit_data.projectile.instance()
			_projectile.setup(_owner.position, target.position)
			_projectile.connect("on_target_reached", self, "_on_complete")
			add_child(_projectile)
			
			var rand_audio = unit_data.attack_audio[Globals.rng.randi_range(0, unit_data.attack_audio.size() - 1)]
			_owner._fire_attack_audio(rand_audio)
			
			# hook up signal to tell target when it's hit
			connect("on_hit", target, "_on_ActionAttack_on_hit")
		
		_started_attack = true
		
func _do_mango_attack():
	for i in range(0, _mango_splash_vectors.size()):
		var projectile = unit_data.projectile.instance()
		var grid_pos = Grid.pos_to_grid_pos(target.position)
		grid_pos += _mango_splash_vectors[i]
		projectile.setup(_owner.position, Grid.grid_pos_to_snapped_pos(grid_pos))
		add_child(projectile)
		_mango_projectiles.append(projectile)
		
		var mango_target = Grid.get_at(grid_pos.x, grid_pos.y)
		if mango_target:
			connect("on_hit", mango_target, "_on_ActionAttack_on_hit")
			_mango_targets.append(mango_target)
			
	# only trigger the complete callback on the main projectile
	_mango_projectiles[0].connect("on_target_reached", self, "_on_complete")
		
func _on_complete():	
	emit_signal("on_hit", self, attack_damage)
	disconnect("on_hit", target, "_on_ActionAttsack_on_hit")
	for unit in _mango_targets:
		disconnect("on_hit", unit, "_on_ActionAttack_on_hit")
	_mango_targets.clear()

	if _projectile:
		_projectile.queue_free()
	for projectile in _mango_projectiles:
		projectile.queue_free()
	._on_complete()
	
""" PUBLIC """
