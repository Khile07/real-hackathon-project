extends Node2D
class_name sfx_player

var arrow_sfx : AudioStreamWAV = preload("uid://braj4vouv27no") # 0
var goblin_die1_sfx : AudioStreamWAV = preload("uid://b1xe5v8rv2jd6") #1
var goblin_die2_sfx : AudioStreamWAV = preload("uid://bm43pyueosw8b") #2
var goblin_die3_sfx : AudioStreamWAV =preload("uid://cca38kpa30gfi") #3
var jump : AudioStreamWAV = preload("uid://m7cwatw8w7tl") #4
var jump2 : AudioStreamWAV = preload("uid://85yki4dkax8a") #5
var jump3 : AudioStreamWAV = preload("uid://dkwi2yl2lyl1m") #6
var parry2 : AudioStreamWAV = preload("uid://c6drwkyjb0bqc") #7
var parry3 : AudioStreamWAV = preload("uid://7ikcfbauygqt") #8

var sfxs = []
@onready var base_node : AudioStreamPlayer = $AudioStreamPlayer
func _ready() -> void:
	sfxs = [arrow_sfx, goblin_die1_sfx, goblin_die2_sfx, goblin_die3_sfx, jump2, jump2, jump3, parry2, parry3]
	SignalManager.sfx_request.connect(play_sfx)
func play_sfx(sfx_int):
	var sound : AudioStreamWAV = sfxs[sfx_int]
	var new_player : AudioStreamPlayer = base_node.duplicate()
	add_child(new_player)
	new_player.stream = sound
	new_player.finished.connect(func(): new_player.queue_free())
	new_player.play()
	
