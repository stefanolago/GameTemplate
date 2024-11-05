extends State

class_name PlayerState

var player: Player
var anim_player: AnimationPlayer

func _ready() -> void:
	await owner.ready
	player = owner as Player
	anim_player = player.animation_player

@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	pass