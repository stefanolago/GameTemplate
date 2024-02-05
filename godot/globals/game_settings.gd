extends Node

## GRAPHICS ##
var window_mode: int = 1
var resolution: int = 0

var haptics_strenght: int = 1 # controller rumble , per ora solo 0 o 1
var difficulty_mult: float = 1
var difficulty_setting: String = "Medium":
	set(value):
		difficulty_setting = value
		match value:   # sono valori default poi da settare a seconda del gioco
			"Story Mode":
				difficulty_mult = 0.0
			"Easy":
				difficulty_mult = 0.5
			"Medium":
				difficulty_mult = 1.0
			"Hard":
				difficulty_mult = 1.5


# save the game settings into a config file, saved locally
func save_settings() -> void:
	print ("SAVING SETTINGS")
	var config:ConfigFile = ConfigFile.new()
	## GRAPHICS ##
	config.set_value("Graphics", "window_mode", window_mode)
	config.set_value("Graphics", "resolution", resolution)
	
	config.set_value("Settings", "haptics_strenght", haptics_strenght)
	config.set_value("Settings", "difficulty_mult", difficulty_mult)
	config.set_value("Settings", "difficulty_setting", difficulty_setting)
	config.save("user://settings_data.cfg")


# load the game settings from the local config file
func load_settings() -> void:
	print ("LOADING SETTINGS")
	var config:ConfigFile = ConfigFile.new()
	
	var f:Error = config.load("user://settings_data.cfg")
	if f != OK: # return if the file doesn't exist
		print ("SETTINGS CONFIG FILE DOES NOT EXISTS")
		return
	
	# set all the saved variables
	## GRAPHICS ##
	window_mode = config.get_value("Graphics", "window_mode")
	resolution = config.get_value("Graphics", "resolution")


	haptics_strenght = config.get_value("Settings", "haptics_strenght")
	difficulty_mult = config.get_value("Settings", "difficulty_mult")
	difficulty_setting = config.get_value("Settings", "difficulty_setting")
