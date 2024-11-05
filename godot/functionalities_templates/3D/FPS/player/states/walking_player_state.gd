extends PlayerState

@export var speed: float = 5.0
@export var acceleration: float = 0.1
@export var deceleration: float = 0.25
@export var top_animation_speed: float = 2.2
var floor_type: int = 0

func enter() -> void:
	anim_player.play("walking", -1.0, 1.0)

func exit() -> void:
	floor_type = player.floor_type
	# FmodServer.play_one_shot_with_params("event:/Character/Footsteps", {"Material": floor_type})

func update(delta: float) -> void:
	if Input.is_action_just_pressed("interact") and player.can_interact():
		transition.emit("InteractingPlayerState")
		return

	player.update_gravity(delta)
	player.update_input(speed, acceleration, deceleration)
	player.update_velocity()

	set_animation_speed(player.velocity.length())
	if player.velocity.length() == 0.0:
		transition.emit("IdlePlayerState")

func set_animation_speed(spd: float) -> void:
	var alpha: float = remap(spd, 0.0, speed, 0.0, 1.0)
	anim_player.speed_scale = lerp(0.0, top_animation_speed, alpha)
