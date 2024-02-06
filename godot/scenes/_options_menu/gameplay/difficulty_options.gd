extends HBoxContainer


@onready var options_button: OptionButton = $Options as OptionButton

const DIFFICULTY_MODE_ARRAY: Array[String] = [
	"Story Mode",
	"Easy",
	"Medium",
	"Hard",
]

func _ready() -> void:
	for difficulty_mode: String in DIFFICULTY_MODE_ARRAY:
		options_button.add_item(difficulty_mode)
	GameSettings.connect('load_all_settings', load_settings)

func load_settings() -> void:
	options_button.selected =  GameSettings.difficulty_setting # load previous settings on UI
	options_button.item_selected.connect(on_difficulty_selected)
	

func on_difficulty_selected(index: int, save_settings:bool = true) -> void:
	GameSettings.difficulty_setting = index
	
	# save settings
	if save_settings:
		GameSettings.save_settings()

