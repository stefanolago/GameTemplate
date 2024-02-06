extends Control

class_name OptionsMenu

signal close_option_menu

## if true then the back button is hidden and the quit button is visible
## if false then the back button is visible and the quit button is visible
## this is needed to not duplicate the option screen since it is exactly the same 
## that we use in the option screen
@export var show_as_pause_screen: bool = false


@onready var back_button: Button = $BackButton
@onready var quit_button: Button = $QuitButton
@onready var tab_container: TabContainer = $TabContainer

func _ready() -> void:
	if show_as_pause_screen:
		back_button.visible = false
		quit_button.visible = true
	else:
		back_button.visible = true
		quit_button.visible = false


func _on_back_button_pressed() -> void:
	close_option_menu.emit()


func _on_quit_button_pressed() -> void:
	get_tree().quit()


func focus_first_available_control() -> void:
	tab_container.get_tab_bar().grab_focus()
