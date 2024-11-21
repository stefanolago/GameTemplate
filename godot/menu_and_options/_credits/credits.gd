extends Control

class_name Credits

signal back_button_pressed


func _on_back_button_pressed() -> void:
	GlobalAudio.play_one_shot("sfx_UI_button_back")
	back_button_pressed.emit()


func focus_first_available_control() -> void:
	($BackButton as Button).grab_focus()
