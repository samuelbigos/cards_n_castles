extends CenterContainer
class_name Widget_Popup
"""
Does XXX.
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

""" PUBLIC """

func setup(str_title, str_button, pressed_obj, pressed_func):
	$VBoxContainer/ColorRect/Label.text = str_title
	$VBoxContainer/ResultButton.text = str_button
	$VBoxContainer/ResultButton.connect("pressed", pressed_obj, pressed_func)
