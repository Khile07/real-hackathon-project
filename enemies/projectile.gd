extends CharacterBody2D
class_name projectile

var move_type : int = 0 # 0 is straight line, 1 is affected by gravity
var gravity : float = 1200
var speed : float = 320
var direction : Vector2 = Vector2.UP
var started : bool = false
var source : Node2D # THIS IS THE OG ENEMY
func _physics_process(delta: float) -> void:
	if started: velocity.y += delta * gravity * move_type
	move_and_slide()
		
func reflected():
	move_type = 0
	speed *= 2
	look_at(source.position)
		
func start(p : player, source_enemy : Node2D):
	look_at(p.position)
	direction = Vector2(cos(rotation),sin(rotation))
	velocity = (speed * direction)
	source = source_enemy
	started = true
