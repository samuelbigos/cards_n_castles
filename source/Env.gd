extends Node2D
class_name Env
tool
"""
Mainly for rendering clutter and blood in the env.
"""

###########
# MEMBERS #
###########

""" PRIVATE """

var _rng = RandomNumberGenerator.new()
var _grass = []
var _grass_played = {}
var _wind_wave_x = 0.0
var _wind_timer = 1.0
var _winding = false

""" PUBLIC """

export var grass_texture = []
export var road_texture = []
export var wind_speed = 100.0
export var wind_frequency = 5.0

###########
# METHODS #
###########

""" PRIVATE """

func _ready():
	_rng.randomize()
	var noise = OpenSimplexNoise.new()
	noise.seed = _rng.randi()
	noise.lacunarity = 1.0
	noise.octaves = 1
	noise.period = 10.0
	noise.persistence = 0.8
	
	var density = 0.1
	var frequency = 0.2
	var size = Globals.SCREEN_SIZE
	size *= density
	for x in range(0, size.x):
		for y in range(0, size.y):
			var chance = noise.get_noise_2d(x, y) + frequency
			var grass_here = randf() < chance
			if grass_here:
				var grass = AnimatedSprite.new()
				grass.frames = grass_texture[_rng.randi_range(0, grass_texture.size() - 1)]
				grass.playing = false
				grass.flip_h = _rng.randi_range(0, 1)
				grass.modulate = Globals.palette_green
				var random_adjust = Vector2(_rng.randi_range(-0.5 / density, 0.5 / density),
											_rng.randi_range(-0.5 / density, 0.5 / density))
				grass.position = Vector2(x / density, y / density)
				grass.position += random_adjust
				_grass.append(grass)
				add_child(grass)
				
			var road_here = randf() > chance + 0.3
			if road_here:
				var road = Sprite.new()
				road.texture = road_texture[_rng.randi_range(0, road_texture.size() - 1)]
				road.flip_h = _rng.randi_range(0, 1)
				road.modulate = Globals.palette_darkergreen
				var random_adjust = Vector2(_rng.randi_range(-0.5 / density, 0.5 / density),
											_rng.randi_range(-0.5 / density, 0.5 / density))
				road.position = Vector2(x / density, y / density)
				road.position += random_adjust
				add_child(road)
		
	$BG.scale = Globals.SCREEN_SIZE
	$BG.modulate = Globals.palette_darkgreen
	
func _process(delta):
	_wind_timer -= delta
	if _wind_timer < 0.0 and not _winding:
		_winding = true
		_wind_wave_x = 0.0
		for grass in _grass:
			_grass_played[grass] = false
	
	if _winding:
		for grass in _grass:
			if not _grass_played[grass] and abs(_wind_wave_x - grass.position.x) < 5.0:
				grass.frame = 0
				grass.play("default")
				_grass_played[grass] = true
		_wind_wave_x += wind_speed * delta
		if _wind_wave_x > Globals.SCREEN_SIZE.x:
			_winding = false
			_wind_timer = wind_frequency + _rng.randf_range(-wind_frequency * 0.5, wind_frequency * 0.5)

""" PUBLIC """
