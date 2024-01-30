extends CanvasLayer


@export var start_game_scene: PackedScene

@onready var options_menu: Control = $Control/OptionsMenu
@onready var credits_screen: Control = $Control/Credits

var music_instance: EventInstance


func _ready() -> void:
	music_instance = FMODRuntime.create_instance_id(FMODGuids.Events.MUSIC_MENU)
	music_instance.start()


func activate_options_menu(activated: bool) -> void:
	options_menu.visible = activated
	for button: Button in $Control/Buttons.get_children():
		button.disabled = activated


func _on_options_button_pressed() -> void:
	FMODRuntime.play_one_shot_id(FMODGuids.Events.UI_CLICK)
	activate_options_menu(true)


func _on_options_menu_close_option_menu() -> void:
	FMODRuntime.play_one_shot_id(FMODGuids.Events.UI_BACK)
	activate_options_menu(false)


func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_credits_button_pressed() -> void:
	FMODRuntime.play_one_shot_id(FMODGuids.Events.UI_CLICK)
	credits_screen.visible = true


func _on_play_button_pressed() -> void:
	FMODRuntime.play_one_shot_id(FMODGuids.Events.UI_CLICK)
	music_instance.stop(FMODStudioModule.FMOD_STUDIO_STOP_ALLOWFADEOUT)
	TransitionLayer.change_scene(start_game_scene)


func _on_play_button_mouse_entered() -> void:
	FMODRuntime.play_one_shot_id(FMODGuids.Events.UI_HOVER)


func _on_options_button_mouse_entered() -> void:
	FMODRuntime.play_one_shot_id(FMODGuids.Events.UI_HOVER)


func _on_credits_button_mouse_entered() -> void:
	FMODRuntime.play_one_shot_id(FMODGuids.Events.UI_HOVER)


func _on_quit_button_mouse_entered() -> void:
	FMODRuntime.play_one_shot_id(FMODGuids.Events.UI_HOVER)