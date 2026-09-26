extends Node2D
class_name enemy_holder

@onready var tower_peasant_scene : PackedScene = preload("uid://ix4fvtcg36jb")
var the_level : level

func set_up(level_node : level):
	the_level = level_node
	var peasant : tower_enemy = the_level.set_up_tower_entity(tower_peasant_scene,Vector2(8,9))
	print(peasant.position)
	
