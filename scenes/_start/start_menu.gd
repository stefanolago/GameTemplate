extends CanvasLayer


@export var start_game_scene: PackedScene


@onready var options_menu: Control = $Control/OptionsMenu
@onready var credits_screen: Control = $Control/Credits

func _on_options_button_pressed() -> void:
	activate_options_menu(true)

func _on_options_menu_close_option_menu() -> void:
	activate_options_menu(false)

func activate_options_menu(activated: bool) -> void:
	options_menu.visible = activated
	for button: Button in $Control/Buttons.get_children():
		button.disabled = activated


func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_credits_button_pressed() -> void:
	credits_screen.visible = true


func _on_play_button_pressed() -> void:
	TransitionLayer.change_scene(start_game_scene)
