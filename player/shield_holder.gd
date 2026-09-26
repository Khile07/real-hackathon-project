extends Node2D
class_name shield_holder

@onready var my_shield  = $shield
var my_player : player

func _ready() -> void:
	my_player = owner

func _physics_process(delta: float) -> void:
	look_at(get_global_mouse_position())
	if not my_player or not my_shield: return
	if my_player.anim_player.current_animation == "idle": my_shield.shield_sprite.visible = true
	else: my_shield.shield_sprite.visible = false
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("parry") and not my_shield.on_cd:
		my_shield.start()
