extends player
class_name tower_enemy

@onready var timer : Timer = $Timer

func _input(event: InputEvent) -> void:
	return
	
func get_blocked_moves() ->Array[Vector2i]:
	return [Vector2i(0,1)]
	
func _ready() -> void:
	timer.timeout.connect(try_move_up)
	timer.start()
	super()

func try_move_up():
	if randf() > 0.7 or dead: return
	if the_level.the_tower.is_move_valid(self, Vector2i(0,-1)):
		try_move_to_tile(Vector2i(0,-1))
