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
	
	options_button.selected = 2 #default medium
	options_button.item_selected.connect(on_difficulty_selected)
	

func on_difficulty_selected(index: int) -> void:
	match index:
		0: # no damage story mode
			GameSettings.difficulty_setting = "Story Mode"
		1: # easy
			GameSettings.difficulty_setting = "Easy"
		2: # medium
			GameSettings.difficulty_setting = "Medium"
		3: # hard
			GameSettings.difficulty_setting = "Hard"
