extends Node


signal load_all_settings
signal saved_settings

## GRAPHICS ##
var window_mode: int = 1
var resolution: int = 0
## GAMEPLAY ##
var difficulty_mult: float = 1
var difficulty_setting: int = 2:
	set(value):
		difficulty_setting = value
		match value:   # sono valori default poi da settare a seconda del gioco
			0: # Story Mode
				difficulty_mult = 0.0
			1: # Easy
				difficulty_mult = 0.5
			2: # Medium
				difficulty_mult = 1.0
			3: # Hard
				difficulty_mult = 1.5
## AUDIO ##
var master_volume: float = 1.0
var music_volume: float = 1.0
var sfx_volume: float = 1.0
## CONTROLS ##
var haptics_strenght: int = 1 # controller rumble , per ora solo 0 o 1

# save the game settings into a config file, saved locally
func save_settings() -> void:
	print ("SAVING SETTINGS")
	var config:ConfigFile = ConfigFile.new()
	## GRAPHICS ##
	config.set_value("Graphics", "window_mode", window_mode)
	config.set_value("Graphics", "resolution", resolution)
	## GAMEPLAY ##
	config.set_value("Gameplay", "difficulty_setting", difficulty_setting)
	## AUDIO ##
	config.set_value("Audio", "master_volume", master_volume)
	config.set_value("Audio", "music_volume", music_volume)
	config.set_value("Audio", "sfx_volume", sfx_volume)
	## CONTROLS ##
	config.set_value("Settings", "haptics_strenght", haptics_strenght)

	config.save("user://settings_data.cfg")
	saved_settings.emit()


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
	## GAMEPLAY ##
	difficulty_setting = config.get_value("Gameplay", "difficulty_setting")
	## AUDIO ##
	master_volume = config.get_value("Audio", "master_volume")
	music_volume = config.get_value("Audio", "music_volume")
	sfx_volume = config.get_value("Audio", "sfx_volume")
	## CONTROLS ##
	haptics_strenght = config.get_value("Settings", "haptics_strenght")

	load_all_settings.emit()
