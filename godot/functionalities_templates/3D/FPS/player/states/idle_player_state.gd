extends PlayerState

@export var speed: float = 5.0
@export var acceleration: float = 0.1
@export var deceleration: float = 0.25

func enter() -> void:
	anim_player.pause()


func exit() -> void:
	pass
	# print("ON IDLE EXIT")


func update(delta: float) -> void:

	if Input.is_action_just_pressed("interact") and player.can_interact():
		print("IDLE INTERACT CAN")
		transition.emit("InteractingPlayerState")
		return

	player.update_gravity(delta)
	player.update_input(speed, acceleration, deceleration)
	player.update_velocity()
	

	if player.velocity.length() > 0.0 and player.is_on_floor():
		transition.emit("WalkingPlayerState")
	
