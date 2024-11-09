extends State

class_name Player3DState

var player: Player3D
var anim_player: AnimationPlayer

func _ready() -> void:
	await owner.ready
	player = owner as Player3D
	anim_player = player.animation_player

@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	pass