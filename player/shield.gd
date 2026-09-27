extends Area2D
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
	length_timer.start()
	on_cd = true
func stop():
	shield_sprite.modulate.a = 0.5
	active = false
	reset_timer.start()

func _physics_process(delta: float) -> void:
	if active:
		for body in get_overlapping_bodies():
			if body is projectile and not body.can_kill_enemies:
				body.reflected()
				SfxScene.play_sfx(randi_range(7,8))
