extends Node2D
class_name level

@onready var player_scene : PackedScene = preload("uid://dquppdafdkibw")
@onready var the_tower : tower = $tower
@onready var the_camera : custom_cam = $camera
@onready var the_enemy_holder : enemy_holder = $enemy_holder
var the_player : player

var current_stage = 0

func _ready() -> void:
	the_tower.set_up(self)
	the_enemy_holder.set_up(self)
	the_camera.set_up(self)
	the_player = set_up_tower_entity(player_scene, Vector2i(8,10), true)
	the_tower.the_player = the_player
	#the_player.position = Vector2(200,200)
	print(the_player)
	
	
func set_up_tower_entity(entity_scene : PackedScene, pos : Vector2i, is_player : bool = false) -> player:
	var entity : player= entity_scene.instantiate()
	entity.tile_pos = pos
	entity.position = entity.tile_pos * 64
	entity.the_level = self
	the_tower.set_occupients(entity,pos)
	if is_player: add_child(entity)
	else: the_enemy_holder.add_child(entity)
	return entity
	
