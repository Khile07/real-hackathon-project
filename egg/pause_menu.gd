extends Control

@onready var overlay : CanvasLayer = $BGLayer
@onready var button : Button = $MenuPanel/MarginContainer/Button

var is_paused : bool = false

func _ready() -> void:
	get_tree().paused = false

func _on_button_pressed() -> void:
	attempt_pause()
		
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"): attempt_pause()
		
func attempt_pause():
	if (is_paused != true):
		get_tree().paused = true
		overlay.visible = true
		is_paused = true
		button.text = "▶"
		SignalManager.pause_open.emit()

	elif (is_paused == true):
		get_tree().paused = false
		overlay.visible = false
		is_paused = false
		button.text = "❚❚"
		SignalManager.pause_close.emit()
