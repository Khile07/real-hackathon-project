extends player
class_name tower_enemy

func _input(event: InputEvent) -> void:
	return
	
func get_blocked_moves() ->Array[Vector2i]:
	return [Vector2i(-1,0)]
