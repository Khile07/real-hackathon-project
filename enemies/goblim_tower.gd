extends Node2D
class_name goblim_tower

@onready var life_duration : Timer = $Timer
@onready var exit_duration : Timer = $Timer
@onready var sprite1 : AnimatedSprite2D = $AnimatedSprite2D
@onready var sprite2 : AnimatedSprite2D = $AnimatedSprite2D2
var leaving :bool
var the_level : level
var velocity = Vector2(0,0)
const max_speed = 80
func _ready() -> void:
	life_duration.start()
	life_duration.timeout.connect(leave)
	sprite1.play("idle")
	sprite2.play("idle")
	

func leave():
	leaving = true
	exit_duration.start()
	exit_duration.timeout.connect(func(): queue_free())
	
func _physics_process(delta: float) -> void:
	if not leaving and the_level and the_level.the_player:
		velocity += position.direction_to(the_level.the_player.position) * 8 * delta
		if velocity.length() > max_speed: velocity.normalized() * max_speed
		position += velocity
	else:
		velocity = velocity.normalized() * max_speed/3
		position += velocity
	 
		
		
