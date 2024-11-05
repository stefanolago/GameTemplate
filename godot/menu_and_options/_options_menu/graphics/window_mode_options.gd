extends HBoxContainer

@onready var options_button: OptionButton = $Options as OptionButton

const WINDOW_MODE_ARRAY: Array[String] = [
	"Fullscreen",
	"Window",
	"Borderless Fullscreen",
	"Borderless Window"
]

func _ready() -> void:
	for window_mode: String in WINDOW_MODE_ARRAY:
		options_button.add_item(window_mode)
	
	options_button.item_selected.connect(on_window_mode_selected)
	GameSettings.load_all_settings.connect(update_settings)
	GameSettings.saved_settings.connect(update_settings)


func update_settings() -> void:
	options_button.selected = GameSettings.window_mode # load previous settings on UI
	on_window_mode_selected(GameSettings.window_mode, false) # apply previous settings, don't save


func on_window_mode_selected(index: int, save_settings:bool = true) -> void:
	match index:
		0: # full screen
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
		1: # window mode
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
		2: # full screen borderless
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
		3: # window mode borderless
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
	
	# save settings only if manually changed, not the first time when loading
	if save_settings:
		GameSettings.window_mode = index
		GameSettings.save_settings()
