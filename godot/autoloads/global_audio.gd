class_name AudioWrapper extends Node

var audio_streams: Dictionary

func _ready() -> void:
	for stream_player: AudioStreamPlayer in $".".get_children():
		audio_streams[stream_player.name] = stream_player
		# make sure nothing is on master
		if stream_player.bus == "Master":
			push_warning("Audio player %s in global audio is set on Master bus" %stream_player.name)

func play_one_shot(stream_name:String) -> void:
	var stream_player:AudioStreamPlayer = audio_streams[stream_name]
	stream_player.play()

func fade_in(stream_name:String, transition_duration:float) -> void:
	var stream_player:AudioStreamPlayer = audio_streams[stream_name]
	var target_db:float = stream_player.volume_db
	var fade_tween:Tween = create_tween()
	stream_player.volume_db = -80
	fade_tween.tween_property(stream_player, "volume_db", target_db, transition_duration).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	fade_tween.play()
	stream_player.play()

func fade_out(stream_name:String, transition_duration:float) -> void:
	var stream_player:AudioStreamPlayer = audio_streams[stream_name]
	var fade_tween:Tween = create_tween()
	var store_volume: float = stream_player.volume_db
	fade_tween.tween_property(stream_player, "volume_db", -80, transition_duration).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
	fade_tween.play()
	await fade_tween.finished
	stream_player.stop()
	stream_player.volume_db = store_volume
