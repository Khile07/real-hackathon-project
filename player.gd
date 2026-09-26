extends CharacterBody2D
class_name player

const movement_delay : float = 0.1
const movement_actions : Dictionary[String, Vector2i] = {
	"left" : Vector2i(-1,0),
	"right" : Vector2i(1,0),
	"down" : Vector2i(0,1),
	"up" : Vector2i(0,-1)
	
}
@onready var sprite : Sprite2D = $Sprite2D
@onready var anim_player : AnimationPlayer = $AnimationPlayer

var stored_next_pixel_pos : Vector2 
var stored_tile_pos : Vector2i
var the_level : level
var tile_pos : Vector2i
var dead : bool = false
var death_spin : float = 180

func _ready() -> void:
	anim_player.animation_finished.connect(finish_anim)
	anim_player.play("idle")
	death_spin += randi_range(0,360)
func _input(event: InputEvent) -> void:
	if anim_player.current_animation != "idle" or dead: return
	for action in movement_actions:
		if event.is_action_pressed(action) and the_level and the_level.the_tower:
			if the_level.the_tower.is_move_valid(movement_actions[action]):
				try_move_to_tile(movement_actions[action])
func try_move_to_tile(dir : Vector2i):
	stored_tile_pos = tile_pos + dir
	stored_next_pixel_pos = (stored_tile_pos)*64
	print(stored_next_pixel_pos, stored_tile_pos, stored_tile_pos)
	match dir:
		Vector2i(-1,0):
			anim_player.play("jump_left")
		Vector2i(1,0):
			anim_player.play("jump_right")
		Vector2i(0,1):
			anim_player.play("jump_down")
		Vector2i(0,-1):
			anim_player.play("jump_up")
	
func finish_anim(anim_name : String):
	print(anim_name)
	if anim_name in ["jump_up","jump_down","jump_left","jump_right"]:
		move_to_stored()
		print("finished prop", tile_pos)
		
func move_to_stored():
	the_level.the_tower.set_occupients(self,stored_tile_pos)
	position = stored_next_pixel_pos
	tile_pos = stored_tile_pos
	anim_player.play("idle")

func get_blocked_moves() ->Array[Vector2i]:
	return [Vector2i(-1,0), Vector2i(1,0), Vector2i(0,1)]

func pushed():
	the_level.the_tower.tiles[tile_pos].occupient = null
	print("AM DEAD")
	dead = true
	anim_player.stop()
	
func _physics_process(delta: float) -> void:
	if not dead: return
	velocity = Vector2(0,640)
	sprite.rotation_degrees += death_spin * delta
	move_and_slide()
	
	
