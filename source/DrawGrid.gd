extends Node2D
class_name DrawGrid
"""
Draws grid.
"""

###########
# MEMBERS #
###########

""" PRIVATE """

""" PUBLIC """

###########
# METHODS #
###########

""" PRIVATE """

func _draw():
	for x in range(0, Grid.grid_size.x):
		for y in range(0, Grid.grid_size.y):
			var rect = Rect2(x * (Grid.cell_size.x + Grid.cell_padding), y * (Grid.cell_size.y + Grid.cell_padding), Grid.cell_size.x, Grid.cell_size.y)
			draw_rect(rect, Globals.palette_darkergreen, false)	
				
""" PUBLIC """
