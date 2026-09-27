extends Control

var win: bool = false
@onready var anim_player: AnimationPlayer = $MarginContainer/WinButtons/MarginContainer/VBoxContainer/PlayButton/AnimationPlayer2
@onready var anim_player2: AnimationPlayer = $MarginContainer/WinButtons/MarginContainer/VBoxContainer/ExitButton/AnimationPlayer2

@onready var play_button_lose : Button = $MarginContainer/LoseButtons/MarginContainer/VBoxContainer/PlayButton
@onready var exit_button_lose : Button = $MarginContainer/LoseButtons/MarginContainer/VBoxContainer/ExitButton
@onready var play_button_win : Button = $MarginContainer/WinButtons/MarginContainer/VBoxContainer/PlayButton
@onready var exit_button_win : Button = $MarginContainer/WinButtons/MarginContainer/VBoxContainer/ExitButton

func _ready() -> void:
	SignalManager.player_dead.connect(_player_dead)
	SignalManager.player_won.connect(_player_won)
	play_button_lose.pressed.connect(lose_play_button)
	play_button_win.pressed.connect(win_play_button)
	exit_button_lose.pressed.connect(lose_leave_button)
	exit_button_win.pressed.connect(win_leave_button)

func _exit_tree() -> void:
	SignalManager.player_dead.disconnect(_player_dead)
	SignalManager.player_won.disconnect(_player_won)

func _player_dead() -> void:
	$LoseBG.visible = true
	$MarginContainer/LoseButtons.visible = true

func _player_won() -> void:
	$WinBG.visible = true
	$MarginContainer/WinButtons.visible = true

func win_play_button() -> void:
	await anim_player.animation_finished
	visible = false
	get_tree().change_scene_to_file("res://level/level.tscn")

func win_leave_button() -> void:
	await anim_player2.animation_finished
	visible = false
	get_tree().quit()

func lose_play_button() -> void:
	visible = false
	get_tree().change_scene_to_file("res://level/level.tscn")

func lose_leave_button() -> void:
	visible = false
	get_tree().quit()
