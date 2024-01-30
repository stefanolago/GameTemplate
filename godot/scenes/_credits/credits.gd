extends Control


func _on_back_button_pressed() -> void:
	FMODRuntime.play_one_shot_id(FMODGuids.Events.UI_BACK)
	visible = false

func _on_back_button_mouse_entered() -> void:
	FMODRuntime.play_one_shot_id(FMODGuids.Events.UI_HOVER)
