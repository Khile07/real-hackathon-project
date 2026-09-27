extends Camera2D
class_name custom_cam

@onready var death_zone : Area2D = $Area2D
var follow : bool = false
var the_level : level
var ending_the_world : bool

func set_up(L : level):
	the_level = L
	death_zone.body_entered.connect(kill_someone)
	
func kill_someone(body : PhysicsBody2D):
	
	if body is player or projectile:
		if not body is player or not body.yeah_im_THE_player_buddy: 
			body.call_deferred("queue_free")
	
func _physics_process(delta: float) -> void:
	if ending_the_world:
		the_level.fader.modulate.a += delta/2
		if the_level.fader.modulate.a >= 1: 
			get_tree().change_scene_to_file("uid://wwv6bafy3vuq")
	if not follow: return
	if position.y <= 360 and the_level.the_player.position.y < position.y: position.y = lerpf(position.y, the_level.the_player.position.y, delta * 4)
	if position.y  <= 360 - (the_level.current_stage)*720:
		follow = false
