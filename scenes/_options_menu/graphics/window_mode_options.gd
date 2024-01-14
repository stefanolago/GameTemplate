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

	var window_mode: int = DisplayServer.window_get_mode()
	var borderless: bool = DisplayServer.window_get_flag(DisplayServer.WINDOW_FLAG_BORDERLESS)

	# selected index is 0 if full screen, 1 if windowed
	var selected_index: int = 0
	if(window_mode == 0):
		# windowed
		selected_index = 1
	# selected index is +2 if borderless
	if(borderless):
		selected_index += 2
	
	options_button.selected = selected_index
	
	options_button.item_selected.connect(on_window_mode_selected)



func on_window_mode_selected(index: int) -> void:
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
