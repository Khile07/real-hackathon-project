extends Control

var win: bool = false
@export var anim_player: AnimationPlayer
@export var anim_player2: AnimationPlayer

@export var play_button : Button
@export var exit_button : Button

func _ready() -> void:
	play_button.pressed.connect(play_button_func)
	exit_button.pressed.connect(leave_button_func)

func play_button_func() -> void:
	if anim_player: await anim_player.animation_finished
	visible = false
	get_tree().change_scene_to_file("res://level/level.tscn")

func leave_button_func() -> void:
	if anim_player2: await anim_player2.animation_finished
	visible = false
	get_tree().quit()
