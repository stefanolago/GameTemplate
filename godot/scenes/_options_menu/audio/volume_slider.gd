extends HSlider

@export var bus_name: String
var bus_index: int

#@export var bus_asset: BusAsset   #FMOD
#var bus: Bus   #FMOD
 
func _ready() -> void:
	#bus = FMODStudioModule.get_studio_system().get_bus(bus_asset.path)   #FMOD
	bus_index = AudioServer.get_bus_index(bus_name)
	drag_ended.connect(_on_drag_ended)
	GameSettings.connect('load_all_settings', load_settings)

func load_settings() -> void:
	# load previous settings on UI
	match bus_name:
		"Master":
			value = GameSettings.master_volume
			on_value_changed(GameSettings.master_volume, false) # apply previous settings, don't save
		"Music":
			value = GameSettings.music_volume 
			on_value_changed(GameSettings.music_volume, false) # apply previous settings, don't save
		"SFX":
			value = GameSettings.sfx_volume 
			on_value_changed(GameSettings.sfx_volume, false) # apply previous settings, don't save
	value_changed.connect(on_value_changed)


func on_value_changed(val: float, save_settings:bool = true) -> void:
	#bus.set_volume(val)     #FMOD
	AudioServer.set_bus_volume_db(
		bus_index,
		linear_to_db(val)
	)
	# save settings
	if save_settings:
		match bus_name:
			"Master":
				GameSettings.master_volume = val
			"Music":
				GameSettings.music_volume = val
			"SFX":
				GameSettings.sfx_volume = val

func _on_drag_ended(_value: bool) -> void:
	GameSettings.save_settings()
