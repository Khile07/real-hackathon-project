extends Camera2D
class_name custom_cam

@onready var death_zone : Area2D = $Area2D
var follow : bool = false
var the_level : level
var ending_the_world : bool
var won : bool = false
var stop : bool = false

func set_up(L : level):
	the_level = L
	death_zone.body_entered.connect(kill_someone)
	
func kill_someone(body : PhysicsBody2D):
	if body is player or projectile:
		if not body is player or not body.yeah_im_THE_player_buddy: 
			if body is player and body.dead:
				body.call_deferred("queue_free")
			if body is balloon_enemy and body.dying:
				body.call_deferred("queue_free")
			if body is projectile:
				body.call_deferred("queue_free")
func _physics_process(delta: float) -> void:
	if ending_the_world:
		the_level.fader.modulate.a += delta/2
		if the_level.fader.modulate.a >= 1 and not won and not stop: 
			stop = true
			SignalManager.player_dead.emit()
			get_tree().change_scene_to_file("uid://mbq6sfditicn")
			
		elif the_level.fader.modulate.a >= 1:
			SignalManager.player_won.emit()
			get_tree().change_scene_to_file("uid://mbq6sfditicn")
			
			
	if not follow: return
	if position.y <= 360 and the_level.the_player.position.y < position.y: position.y = lerpf(position.y, the_level.the_player.position.y, delta * 4)
	if position.y  <= 360 - (the_level.current_stage)*720:
		follow = false
		the_level.the_enemy_holder.spawn_enemies(the_level.current_stage)
		SignalManager.wave_started.emit()
