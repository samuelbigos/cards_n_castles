extends Node2D
class_name AreaHighlights
"""
Draws required highlighted areas on the grid.
"""

###########
# MEMBERS #
###########

""" PRIVATE """

var _draw_deploy = false
var _draw_timer = 0.15
var _draw_offset_deploy = 0

""" PUBLIC """

var animate_deploy = false

###########
# METHODS #
###########

""" PRIVATE """

func _process(delta):
	_draw_timer -= delta
	if _draw_timer < 0.0:
		if animate_deploy:
			_draw_offset_deploy += 1
			if _draw_offset_deploy > 3:
				_draw_offset_deploy -= 4
				
		_draw_timer = 0.1
		if animate_deploy:
			update()

func _draw():
	if _draw_deploy:
		var rect_pos = Globals.DEPLOY_AREA_POS * (Grid.CELL_SIZE + Vector2(Grid.CELL_PADDING, Grid.CELL_PADDING))
		rect_pos -= Vector2(Grid.CELL_PADDING, Grid.CELL_PADDING) * 0.5
		var rect_size = Globals.DEPLOY_AREA_SIZE * (Grid.CELL_SIZE + Vector2(Grid.CELL_PADDING, Grid.CELL_PADDING))
		rect_size -= Vector2(Grid.CELL_PADDING, Grid.CELL_PADDING)
		rect_size += Vector2(Grid.CELL_PADDING, Grid.CELL_PADDING)
		_draw_dashed_line(rect_pos + Vector2(_draw_offset_deploy, 0.0), rect_pos + Vector2(rect_size.x, 0.0), Globals.palette_pale, 1, 2)
		_draw_dashed_line(rect_pos + Vector2(0.0, _draw_offset_deploy), rect_pos + Vector2(0.0, rect_size.y), Globals.palette_pale, 1, 2)
		_draw_dashed_line(rect_pos + Vector2(rect_size.x, _draw_offset_deploy), rect_pos + Vector2(rect_size.x, rect_size.y), Globals.palette_pale, 1, 2)
		_draw_dashed_line(rect_pos + Vector2(_draw_offset_deploy, rect_size.y), rect_pos + Vector2(rect_size.x, rect_size.y), Globals.palette_pale, 1, 2)
		
func _draw_dashed_line(from, to, color, width, dash_length = 5):
	width = 2
	var length = (to - from).length()
	var normal = (to - from).normalized()
	var dash_step = normal * dash_length
	
	var draw_flag = true
	var segment_start = from
	var steps = length/dash_length
	for start_length in range(0, steps):
		var segment_end = segment_start + dash_step
		if draw_flag:
			draw_line(segment_start, segment_end, color, width)

		segment_start = segment_end
		draw_flag = !draw_flag
	
func _on_Game_state_change(from, to):
	match to:
		Globals.State.DEPLOY:
			#_draw_deploy = true
			update()
			
	match from:
		Globals.State.DEPLOY:
			#_draw_deploy = false
			update()

""" PUBLIC """
