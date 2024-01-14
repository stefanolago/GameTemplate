extends BaseOption

@onready var sfx_sound_stream: AudioStreamPlayer = $SFXSound

func _on_confirm_pressed() -> void:
	print("AUDIO")


func _on_sfx_slider_drag_ended(_value_changed:bool) -> void:
	sfx_sound_stream.play()
