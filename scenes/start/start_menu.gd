extends CanvasLayer


func _on_options_button_pressed() -> void:
	options_menu(true)

func _on_options_menu_close_option_menu() -> void:
	options_menu(false)

func options_menu(activated: bool) -> void:
	$Control/OptionsMenu.visible = activated
	for button: Button in $Control/Buttons.get_children():
		button.disabled = activated


func _on_quit_button_pressed() -> void:
	get_tree().quit()