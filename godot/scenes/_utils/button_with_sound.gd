extends Button

## a button configured to play a sound when the mouse enters and when it is pressed, works with fmod
class_name ButtonWithSound

#@export var pressed_sound_guid: String = FMODGuids.Events.UI_CLICK   #FMOD
#@export var on_mouse_enter_sound_guid: String = FMODGuids.Events.UI_HOVER   #FMOD


func _ready() -> void:
	pressed.connect(_on_pressed)
	mouse_entered.connect(_on_mouse_entered)
	focus_entered.connect(_on_focus_entered)


func _on_pressed() -> void:
	#if pressed_sound_guid != "":   #FMOD
		#FMODRuntime.play_one_shot_id(pressed_sound_guid)   #FMOD
	GlobalAudio.play_stream("sfx_UI_button_click")
	Input.start_joy_vibration(0,1 * GameSettings.haptics_strenght,1 * GameSettings.haptics_strenght,0.1)


func _on_mouse_entered() -> void:
	GlobalAudio.play_stream("sfx_UI_button_hover")
	#if on_mouse_enter_sound_guid != "":
		#FMODRuntime.play_one_shot_id(on_mouse_enter_sound_guid)   #FMOD


func _on_focus_entered() -> void: #se usi freccie o controller usiamo lo stesso
	GlobalAudio.play_stream("sfx_UI_button_hover")
	#if on_mouse_enter_sound_guid != "":   #FMOD
		#FMODRuntime.play_one_shot_id(on_mouse_enter_sound_guid)   #FMOD
