extends Control

class_name BaseOption

func _on_confirm_pressed() -> void:
	print("BASE OPTION")
	Input.start_joy_vibration(0,1 * GameSettings.haptics_strenght,1 * GameSettings.haptics_strenght,0.1)
