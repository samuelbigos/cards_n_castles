extends Node

enum State {
	NONE,
	DEPLOY,
	BATTLE,
	RESULTS
}

const SCREEN_SIZE = Vector2(320, 240)

const DEPLOY_AREA_POS = Vector2(1, 2)
const DEPLOY_AREA_SIZE = Vector2(5, 8)

# darkgreen
var palette_ground = Color("0c2c2d")
var palette_grass = Color("154b4d")
var palette_dirt = Color("071c1e")
var palette_enemy = Color("d1d1d1")
var palette_enemy_accent = Color("812a0d")
var palette_player = Color("d1d1d1")
var palette_player_accent = Color("2f7c89")
var palette_blood = Color("812a0d")
var palette_grid = Color("d1d1d1")

# SLSO8
#var palette_pale = Color("ffd4a3")
#var palette_darkgreen = Color("203c56")
#var palette_enemy = Color("8d697a")
#var palette_blood = Color("0d2b45")
#var palette_player = Color("ffaa5e")
#var palette_green = Color("544e68")
#var palette_darkergreen = Color("0d2b45")

# SLSO8
#var palette_pale = Color("efd8a1")
#var palette_darkgreen = Color("39571c")
#var palette_enemy = Color("8d697a")
#var palette_blood = Color("ef3a0c")
#var palette_player = Color("ef3a0c")
#var palette_green = Color("a58c27")
#var palette_darkergreen = Color("1f240a")

# darkgreen
#var palette_ground = Color("63787d")
#var palette_grass = Color("8ea091")
#var palette_dirt = Color("515262")
#var palette_enemy = Color("c9cca1")
#var palette_enemy_accent = Color("8b4049")
#var palette_player = Color("c9cca1")
#var palette_player_accent = Color("caa05a")
#var palette_blood = Color("543344")
#var palette_grid = Color("515262")

var rng = RandomNumberGenerator.new()

# utils
func is_over_deploy_zone(pos):
	var rect_pos = Globals.DEPLOY_AREA_POS * (Grid.CELL_SIZE + Vector2(Grid.CELL_PADDING, Grid.CELL_PADDING))
	var rect_size = Globals.DEPLOY_AREA_SIZE * (Grid.CELL_SIZE + Vector2(Grid.CELL_PADDING, Grid.CELL_PADDING))
	return Rect2(rect_pos, rect_size).has_point(pos)
