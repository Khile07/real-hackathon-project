extends Node2D
class_name shield

@onready var length_timer : Timer = $length_timer
@onready var reset_timer : Timer = $reset_timer
@onready var shield_sprite : Sprite2D = $shield_sprite
var on_cd : bool 
var active : bool 
func _ready() -> void:
	length_timer.timeout.connect(stop)
	reset_timer.timeout.connect(func(): on_cd = false)
	stop()
func start():
	shield_sprite.modulate.a = 1.0
	active = true
func stop():
	shield_sprite.modulate.a = 0.5
	active = false
