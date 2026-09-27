extends Control

@onready var overlay : CanvasLayer = $BGLayer
@onready var button : Button = $MenuPanel/MarginContainer/Button

var is_paused : bool = false

func _ready() -> void:
	get_tree().paused = false

func _on_button_pressed() -> void:
	if (is_paused != true):
		get_tree().paused = true
		overlay.visible = true
		is_paused = true
		button.text = "▶"

	elif (is_paused == true):
		get_tree().paused = false
		overlay.visible = false
		is_paused = false
		button.text = "❚❚"
