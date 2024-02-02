extends BaseOption

# TODO save keybindings to restore for next sessions

@onready var container: VBoxContainer = $ScrollContainer/ButtonsContainer
@onready var keypress_popup: ColorRect = $KeyPressPopup
var keybinding_button: PackedScene = preload("res://scenes/_options_menu/control/keybinding_button.tscn")


var configurable_inputs: Array[StringName]
var waiting_for_input: bool = false
var input_to_change: StringName

# This dictionary contains the list of inputs that are in the custom ones and 
# that, when remapped, should also remap the associated built in action
var custom_inputs_that_reflect_on_built_in_inputs: Dictionary = {
	"left": ["ui_left"],
	"right": ["ui_right"],
	"up": ["ui_up"],
	"down": ["ui_down"]
}

func _ready() -> void:
	var inputs: Array[StringName] = InputMap.get_actions()

	# retrieve the possible actions, by removing the built-in ones
	for action: StringName in inputs:
		if(!action.contains("ui_")):
			configurable_inputs.append(action)

	# add the actions as rows in the keybinds container
	for input: StringName in configurable_inputs:
		var button: KeybindingButton = keybinding_button.instantiate()
		container.add_child(button)
		button.input_name = input
		button.change_keybinding.connect(_on_keybinding_button_change_keybinding)


# when the change button of a row is pressed, then the 
# popup appears and the game waits for an input
func _on_keybinding_button_change_keybinding(input: StringName) -> void:
	waiting_for_input = true
	keypress_popup.visible = true
	input_to_change = input


# if it is waiting for an input then manage the reconfiguration of the keybind
func _input(event: InputEvent) -> void:
	if(waiting_for_input && (event is InputEventKey || event is InputEventMouseButton) && !event.is_pressed()):

		# if the key pressed is different than the one that the 
		# selected event already has assigned
		if(!InputMap.action_has_event(input_to_change, event)):
			# remove the assigned key if it is already binded 
			# to an action
			remove_inputevent(event)
			
			# add the new event to the action
			action_add_event(input_to_change, event)

			# if the action has more than two events, then remove the oldest one
			remove_extra_events(input_to_change)

			# update the keybinding buttons
			for button: KeybindingButton in container.get_children():
				button.update_content()

		# close the popup
		waiting_for_input = false
		keypress_popup.visible = false


# remove an inputevent from all of the actions to which it is binded
func remove_inputevent(event: InputEvent) -> void:
	for action: StringName in InputMap.get_actions():
		if InputMap.action_has_event(action, event):
			InputMap.action_erase_event(action, event)


# limit the number of inputevents an action can have registered to it
func remove_extra_events(action: StringName) -> void:
	var input_events: Array[InputEvent] = InputMap.action_get_events(action)
	if(len(input_events) > 2):
		action_erase_event(action, input_events[0])



# adds an input event to a specific action, then check if the action has a reflection on the
# built in actions and set the input event to those actions too
func action_add_event(action_name: StringName, event: InputEvent) -> void:
	# add the event to the action
	InputMap.action_add_event(action_name, event)

	# check the dictionary to see if there are built in function to remap too
	if action_name in custom_inputs_that_reflect_on_built_in_inputs.keys():
		for built_in_action: StringName in custom_inputs_that_reflect_on_built_in_inputs[action_name]:
			InputMap.action_add_event(built_in_action, event)


# remove an input event from a specific action, then check if the action has a reflection on the
# built in actions and remove the input event from those actions too
func action_erase_event(action_name: StringName, event: InputEvent) -> void:
	# check the dictionary to see if there are built in function to remap too
	if action_name in custom_inputs_that_reflect_on_built_in_inputs.keys():
		for built_in_action: StringName in custom_inputs_that_reflect_on_built_in_inputs[action_name]:
			InputMap.action_erase_event(built_in_action, event)
	
	InputMap.action_erase_event(action_name, event)