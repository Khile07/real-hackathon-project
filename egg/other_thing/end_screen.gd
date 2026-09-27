extends Control

var win: bool = false
@onready var anim_player: AnimationPlayer = $MarginContainer/WinButtons/MarginContainer/VBoxContainer/PlayButton/AnimationPlayer2
@onready var anim_player2: AnimationPlayer = $MarginContainer/WinButtons/MarginContainer/VBoxContainer/ExitButton/AnimationPlayer2

func _ready() -> void:
	SignalManager.player_dead.connect(_player_dead)
	SignalManager.player_won.connect(_player_won)

func _player_dead() -> void:
	$LoseBG.visible = true
	$MarginContainer/LoseButtons.visible = true

func _player_won() -> void:
	$WinBG.visible = true
	$MarginContainer/WinButtons.visible = true

func _on_play_button_pressed() -> void:
	await anim_player.animation_finished
	get_tree().change_scene_to_file("res://level/level.tscn")

func _on_exit_button_pressed() -> void:
	await anim_player2.animation_finished
	get_tree().quit()
