extends Node2D
class_name enemy_holder

@onready var tower_peasant_scene : PackedScene = preload("uid://ix4fvtcg36jb")
@onready var proj_balloon_scene : PackedScene = preload("uid://cr6ab512dq7oq")

var the_level : level

func set_up(level_node : level):
	the_level = level_node
	var peasant : tower_enemy = the_level.set_up_tower_entity(tower_peasant_scene,Vector2(8,9))
	var balloon : balloon_enemy = proj_balloon_scene.instantiate()
	add_child(balloon)
	balloon.position = Vector2(128,512)
	balloon.set_up(the_level)	
	
