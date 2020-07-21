extends Node

enum State {
	NONE,
	DEPLOY,
	BATTLE,
	RESULTS
}

const DEPLOY_AREA_POS = Vector2(1, 2)
const DEPLOY_AREA_SIZE = Vector2(5, 8)

var palette_pale = Color("d1d1d1")
var palette_darkgreen = Color("0c2c2d")
var palette_brown = Color("812a0d")
var palette_teal = Color("2f7c89")
var palette_green = Color("154b4d")
var palette_darkergreen = Color("071c1e")

# utils
func is_over_deploy_zone(pos):
	var rect_pos = Globals.DEPLOY_AREA_POS * (Grid.CELL_SIZE + Vector2(Grid.CELL_PADDING, Grid.CELL_PADDING))
	var rect_size = Globals.DEPLOY_AREA_SIZE * (Grid.CELL_SIZE + Vector2(Grid.CELL_PADDING, Grid.CELL_PADDING))
	return Rect2(rect_pos, rect_size).has_point(pos)
