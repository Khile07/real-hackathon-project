extends Node2D
class_name level

@onready var player_scene : PackedScene = preload("uid://dquppdafdkibw")
@onready var the_tower : tower = $tower

var the_player : player

func _ready() -> void:
	the_tower.create_tiles()
	the_player = player_scene.instantiate()
	the_player.tile_pos = Vector2i(8,10)
	the_player.position = the_player.tile_pos * 64
	the_player.the_level = self
	add_child(the_player)
	the_tower.the_player = the_player
	#the_player.position = Vector2(200,200)
	print(the_player)
	
