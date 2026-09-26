extends CharacterBody2D
class_name balloon_enemy

var floater : float = 0
var the_level : level

var projectile_scene : PackedScene
var attack_timer : Timer


func set_up(L : level) -> void:
	projectile_scene = load("uid://chpu7fcf0q4w")
	attack_timer = $attack_timer
	the_level = L
	attack_timer.timeout.connect(try_attack)
	attack_timer.start()

func _physics_process(delta: float) -> void:
	velocity.y = sin(floater) *128
	floater += delta 
	if floater > PI * 2: floater = 0
	move_and_slide()
		
func try_attack():
	if not the_level or not the_level.the_player: return
	if randf() >0.6: return
	var proj : projectile = projectile_scene.instantiate()
	the_level.add_child(proj)
	proj.position = position
	if randf() > 0.5:
		proj.move_type = 1
		proj.speed *= 2.5
	proj.start(the_level.the_player, self)
	
