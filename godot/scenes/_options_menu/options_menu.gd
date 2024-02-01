extends Control

signal close_option_menu

## is it working?
@export var show_as_pause_screen: bool = false


@onready var back_button: Button = $BackButton
@onready var quit_button: Button = $QuitButton

func _ready() -> void:
	if show_as_pause_screen:
		back_button.visible = false
		quit_button.visible = true
	else:
		back_button.visible = true
		quit_button.visible = false


func _on_back_button_pressed() -> void:
	FMODRuntime.play_one_shot_id(FMODGuids.Events.UI_BACK)
	close_option_menu.emit()


func _on_back_button_mouse_entered() -> void:
	FMODRuntime.play_one_shot_id(FMODGuids.Events.UI_HOVER)


func _on_quit_button_pressed() -> void:
	get_tree().quit()