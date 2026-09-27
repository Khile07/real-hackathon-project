extends CharacterBody2D
class_name projectile

var move_type : int = 0 # 0 is straight line, 1 is affected by gravity
var gravity : float = 1200
var speed : float = 320
var direction : Vector2 = Vector2.UP
var started : bool = false
var source : Node2D # THIS IS THE OG ENEMY
var can_kill_enemies : bool = false
func _physics_process(delta: float) -> void:
	if started: velocity.y += delta * gravity * move_type
	move_and_slide()
		
func reflected():
	look_at(source.position)
	direction = Vector2(cos(rotation),sin(rotation))
	move_type = 0
	speed *= 1.5
	velocity = (speed * direction)
	can_kill_enemies = true
	
		
func start(p : player, source_enemy : Node2D):
	look_at(p.position)
	direction = Vector2(cos(rotation),sin(rotation))
	velocity = (speed * direction)
	if move_type == 1:
		velocity.y += -600
	source = source_enemy
	started = true
	$Area2D.body_entered.connect(kill)
	
func kill(b : PhysicsBody2D):
	if b is player and not can_kill_enemies:
		b.pushed()
	if b is balloon_enemy and can_kill_enemies:
		b.die_start()
	
