extends Control

func _on_exit_button_pressed() -> void:
	get_tree().quit()

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("uid://b2tsoukkog167")
	SignalManager.pause_close.emit()
func _ready() -> void:
	SignalManager.pause_open.emit()
