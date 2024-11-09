extends Player3DState

var interacting_object: Node

func enter() -> void:
	anim_player.pause()
	interacting_object = player.interact_cast_result
	interacting_object.connect("interaction_finished", _on_interaction_finished)
	interacting_object.emit_signal("interacted")
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


func exit() -> void:
	# print("EXITING INTERACTION STATE")
	if interacting_object:
		if is_instance_valid(interacting_object):
			interacting_object.disconnect("interaction_finished", _on_interaction_finished)
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func update(delta: float) -> void:
	player.update_gravity(delta)


func _on_interaction_finished() -> void:
	# print("INTERACTING PLAYER STATE: Interaction finished")
	# wait 0.1 seconds before transitioning so that if the 
	# player has just interacted with an object, then the
	# interaction doesn't just restart immediately
	await get_tree().create_timer(0.1).timeout

	# print("Transitioning to IdlePlayerState")
	transition.emit("IdlePlayerState")
