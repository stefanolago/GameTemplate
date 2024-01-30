extends Control

signal close_option_menu

func _on_back_button_pressed() -> void:
	FMODRuntime.play_one_shot_id(FMODGuids.Events.UI_BACK)
	close_option_menu.emit()


func _on_back_button_mouse_entered() -> void:
	FMODRuntime.play_one_shot_id(FMODGuids.Events.UI_HOVER)
