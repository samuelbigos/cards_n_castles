extends Node

export var id : String = ""
export var sprite : StreamTexture = null
export var sprite_bg : StreamTexture = null
export var initiative : int = 0 # higher initiative goes first
export var attack_range : int = 1 # attack range in cells
export var move_and_shoot : bool = true # can move and shoot on same turn
export var damage : int = 1 # damage per attack
export var health : int = 1 # damage can take before being destroyed
export var move_range : int = 1 # move range in cells
export var can_move : bool = true # i.e. false for walls
