extends CanvasLayer

@onready var animation_player: AnimationPlayer = $TransitionAnimationPlayer

func change_scene(target: PackedScene) -> void:
	animation_player.play("fade_to_black")
	get_tree().paused = true
	await animation_player.animation_finished
	get_tree().paused = false
	get_tree().change_scene_to_packed(target)
	animation_player.play_backwards("fade_to_black")


func change_scene_to_file(target: String) -> void:
	animation_player.play("fade_to_black")
	get_tree().paused = true
	await animation_player.animation_finished
	get_tree().paused = false
	get_tree().change_scene_to_file(target)
	animation_player.play_backwards("fade_to_black")
