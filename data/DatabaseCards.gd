extends Node
"""
Stores all cards and allows other systems to access their data.
"""

###########
# MEMBERS #
###########

""" PUBLIC """

###########
# METHODS #
###########

""" PUBLIC """

###
func get_card_by_id(id: String):
	for card in get_children():
		if card.id == id:
			return card
			
	return null


""" PRIVATE """

###
func _ready():
	pass

##############
### PUBLIC ###
##############

