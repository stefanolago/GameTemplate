extends Control

@export var start_menu_scene: PackedScene

func _ready():
	$AnimationPlayer.play("reveal_theme_and_wildcards")


func go_to_game_start_scene():
	TransitionLayer.change_scene(start_menu_scene)
