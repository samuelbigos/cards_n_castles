extends Node

export var id : String = ""
export var sprite : StreamTexture = null
export var sprite_accent : StreamTexture = null
export var initiative : int = 0 # higher initiative goes first
export var attack_range : int = 1 # attack range in cells
export var min_attack_range : int = 1
export var move_and_shoot : bool = true # can move and shoot on same turn
export var prefer_max_range : bool = true # won't move if an enemy is in range
export var damage : int = 1 # damage per attack
export var health : int = 1 # damage can take before being destroyed
export var move_count : int = 1 # move range in cells
export var attack_count : int = 1
export var mango_attack : bool = false # special case for mangonel area attack
export var projectile : PackedScene = null
