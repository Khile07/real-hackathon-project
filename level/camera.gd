extends Camera2D
class_name custom_cam

@onready var death_zone : Area2D = $Area2D
var follow : bool = false
var the_level : level

func set_up(L : level):
	the_level = L
	death_zone.body_entered.connect(kill_someone)
	
func kill_someone(body : PhysicsBody2D):
	if body is player:
		body.call_deferred("queue_free")
		print(body, " is destroyed")
func _physics_process(delta: float) -> void:
	if not follow: return
	position.y = lerpf(position.y, the_level.the_player.position.y, delta * 4)
	
