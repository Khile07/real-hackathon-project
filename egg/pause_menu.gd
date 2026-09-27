extends CanvasLayer

@onready var overlay : Panel = $Panel
@onready var button : Button = $MenuPanel/MarginContainer/Button
@onready var menu_options : Panel = $MenuPanel2

var is_paused : bool = false

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("uid://b2tsoukkog167")

func _on_exit_button_pressed() -> void:
	get_tree().quit()

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
		menu_options.visible = true
		is_paused = true
		button.text = "▶"
		SignalManager.pause_open.emit()

	elif (is_paused == true):
		get_tree().paused = false
		overlay.visible = false
		menu_options.visible = false
		is_paused = false
		button.text = "❚❚"
		SignalManager.pause_close.emit()
