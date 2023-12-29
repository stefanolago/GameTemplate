extends Control

signal close_option_menu

func _on_back_button_pressed():
	close_option_menu.emit()

