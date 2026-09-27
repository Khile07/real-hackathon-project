extends CharacterBody2D
class_name balloon_enemy

var floater : float = 0
var the_level : level

var projectile_scene : PackedScene
var attack_timer : Timer

var anim_player : AnimationPlayer
var dying : bool = false
var falling : bool = false
func set_up(L : level) -> void:
	anim_player = $AnimationPlayer
	projectile_scene = load("uid://chpu7fcf0q4w")
	attack_timer = $attack_timer
	the_level = L
	attack_timer.timeout.connect(try_attack)
	attack_timer.start()
	floater = randf_range(0,2 * PI)
	anim_player.play("idle")
	anim_player.animation_finished.connect(func(_n): anim_player.play("idle"))

func _physics_process(delta: float) -> void:
	if dying: 
		rotation_degrees += delta * 360
		move_and_slide()
		return
	velocity.y = sin(floater) *128
	floater += delta 
	if floater > PI * 2: floater = 0
	move_and_slide()
		
func try_attack():
	if dying: return
	if not the_level or not the_level.the_player: return
	if randf() >0.6: return
	anim_player.play("attack")
	var proj : projectile = projectile_scene.instantiate()
	proj.global_position = global_position
	the_level.add_child(proj)
	proj.global_position = global_position
	if randf() > 0.5:
		proj.move_type = 1
		proj.speed *= 1.5
	proj.start(the_level.the_player, self)
	
func die_start():
	anim_player.play("death")
	dying = true
	print("DYINGG")
	
func fall():
	anim_player.play("falling")
	falling = true
	velocity = Vector2(0,400)
	print("FALLOING")
	
	
