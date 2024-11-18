extends CanvasLayer

# TODO Substitute with proper state machines
enum MenuState {
	MAIN_VISIBLE,
	OPTIONS_VISIBLE,
	CREDITS_VISIBLE
}

@export var start_game_scene: PackedScene

#var music_instance: EventInstance    #FMOD
var state: MenuState = MenuState.MAIN_VISIBLE:
	set(value):
		state = value
		match state:
			MenuState.MAIN_VISIBLE:
				enable_main_screen(true)
				enable_options_screen(false)
				enable_credits_screen(false)
			MenuState.OPTIONS_VISIBLE:
				enable_main_screen(false)
				enable_options_screen(true)
				enable_credits_screen(false)
			MenuState.CREDITS_VISIBLE:
				enable_main_screen(false)
				enable_options_screen(false)
				enable_credits_screen(true)

@onready var play_button: Button = $Control/Buttons/PlayButton
@onready var options_menu: OptionsMenu = $Control/OptionsMenu
@onready var credits_screen: Credits = $Control/Credits
@onready var quit_button: Button = $Control/Buttons/QuitButton

func _ready() -> void:
	#music_instance = FMODRuntime.create_instance_id(FMODGuids.Events.MUSIC_MENU)  #FMOD
	#music_instance.start()  #FMOD
	GlobalAudio.fade_in("music_menu_main", 1)
	enable_main_screen(true)
	
	# hide the quit button if we are in the web version
	quit_button.visible = (OS.get_name() != "Web")


func enable_main_screen(enable: bool) -> void:
	# disable the buttons in the background and stop the ability to get focus
	# when the option screen is open 
	for button: Button in $Control/Buttons.get_children():
		button.disabled = not enable
		button.focus_mode = Control.FOCUS_ALL if enable else Control.FOCUS_NONE

	# check if there are controllers connected, in that case focus the first visible and focusable button
	if Input.get_connected_joypads().size() > 0:
		# var node_focused: Control = get_viewport().gui_get_focus_owner()
		play_button.grab_focus()


func enable_options_screen(enable: bool) -> void:
	options_menu.visible = enable
	if enable:
		options_menu.focus_first_available_control()


func enable_credits_screen(enable: bool) -> void:
	credits_screen.visible = enable
	if enable:
		credits_screen.focus_first_available_control()


func _on_credits_button_pressed() -> void:
	state = MenuState.CREDITS_VISIBLE


func _on_credits_back_button_pressed() -> void:
	GlobalAudio.play_stream("sfx_UI_button_back")
	state = MenuState.MAIN_VISIBLE


func _on_options_button_pressed() -> void:
	state = MenuState.OPTIONS_VISIBLE


func _on_options_menu_close_option_menu() -> void:
	state = MenuState.MAIN_VISIBLE


func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_play_button_pressed() -> void:
	GameStats.reset_stats() # initialize the stats
	GameStats.save_stats() # write the config file to save stats
	#music_instance.stop(FMODStudioModule.FMOD_STUDIO_STOP_ALLOWFADEOUT)   #FMOD
	GlobalAudio.fade_out("music_menu_main", 1)
	TransitionLayer.change_scene(start_game_scene)


func _input(_event: InputEvent) -> void:
	if get_viewport().gui_get_focus_owner() == null:
		#play_button.grab_focus()
		match state:
			MenuState.MAIN_VISIBLE:
				play_button.grab_focus()
			MenuState.OPTIONS_VISIBLE:
				options_menu.focus_first_available_control()
			MenuState.CREDITS_VISIBLE:
				credits_screen.focus_first_available_control()
