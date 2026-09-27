extends CharacterBody2D
class_name balloon_enemy

var floater : float = 0
var the_level : level

var projectile_scene : PackedScene
var attack_timer : Timer

var anim_player : AnimationPlayer
var dying : bool = false
var falling : bool = false
var ideal_x : float = 0
func set_up(L : level) -> void:
	ideal_x = [randi_range(0,330), randf_range(668,1000)][randi_range(0,1)]
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
		move_and_slide()
		return
	if position.x - ideal_x < -16: velocity.x = 48
	if position.x - ideal_x > 16: velocity.x =-48
	velocity.y = sin(floater) *32
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
		proj.speed *= 0.6
	SignalManager.sfx_request.emit(0)
	proj.start(the_level.the_player, self)
	
func die_start():
	anim_player.play("death")
	SignalManager.sfx_request.emit(randi_range(1,3))
	dying = true
	
func fall():
	rotation_degrees += randi_range(-60,60)
	anim_player.play("falling")
	falling = true
	velocity = Vector2(0,400)
	
	
