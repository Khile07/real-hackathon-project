extends Node2D
class_name shield_holder

@onready var shield  = $shield


func _physics_process(delta: float) -> void:
	look_at(get_global_mouse_position())
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("parry"):
		pass
