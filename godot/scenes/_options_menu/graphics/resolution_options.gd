extends HBoxContainer


@onready var options_button: OptionButton = $Options as OptionButton

const RESOLUTION_DICTIONARY: Dictionary = {
	"1152 x 648" : Vector2i(1152, 648),
	"1280 x 720" : Vector2i(1280, 720),
	"1920 x 1080" : Vector2i(1920, 1080)

}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for resolution: String in RESOLUTION_DICTIONARY:
		options_button.add_item(resolution)
	
	options_button.selected = GameSettings.resolution # load previous settings
	on_resolution_selected(GameSettings.resolution, false) # apply previous settings
	options_button.item_selected.connect(on_resolution_selected)

func on_resolution_selected(index: int, save_settings:bool = true) -> void:
	var window_size: Vector2i = RESOLUTION_DICTIONARY.values()[index]
	DisplayServer.window_set_size(window_size)

	# save settings
	if save_settings:
		GameSettings.resolution = index
		GameSettings.save_settings()

