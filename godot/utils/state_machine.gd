extends Node

class_name StateMachine

@export var initial_state: State

var current_state: State
var states: Dictionary = {}

func _ready() -> void:
	await owner.ready
	
	for child: Node in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			(child as State).transition.connect(_on_child_transition)
	
	if initial_state:
		initial_state.enter()
		current_state = initial_state


func _process(delta: float) -> void:
	if current_state:
		current_state.update(delta)


func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)


func _on_child_transition(new_state_name: String) -> void:
	
	var new_state: State = states.get(new_state_name.to_lower())
	if !new_state:
		push_warning("State does not exist: " + new_state_name)
		return
	
	if current_state:
		current_state.exit()
	
	new_state.enter()
	current_state = new_state


# func force_transition_to_state(new_state_name: String) -> void:
# 	_on_child_transition(new_state_name)

