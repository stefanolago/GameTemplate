extends BaseOption

# TODO save keybindings to restore for next sessions

@onready var container: VBoxContainer = $ScrollContainer/ButtonsContainer
@onready var keypress_popup: ColorRect = $KeyPressPopup
var keybinding_button: PackedScene = preload("res://scenes/_options_menu/control/keybinding_button.tscn")

var configurable_inputs: Array[StringName]
var waiting_for_input: bool = false
var input_to_change: StringName

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
			InputMap.action_add_event(input_to_change, event)

			# if the action has more than two events, then remove the oldest one
			remove_extra_events(input_to_change)

			# update the keybinding buttons
			for button: KeybindingButton in container.get_children():
				button.update_content()

		# close the popup
		waiting_for_input = false
		keypress_popup.visible = false


func remove_inputevent(event: InputEvent) -> void:
	for action: StringName in InputMap.get_actions():
		for inputevent: InputEvent in InputMap.action_get_events(action):
			if(inputevent.as_text() == event.as_text()):
				InputMap.action_erase_event(action, inputevent)


func remove_extra_events(action: StringName) -> void:
	var inputevents: Array[InputEvent] = InputMap.action_get_events(action)
	if(len(inputevents) > 2):
		InputMap.action_erase_event(action, inputevents[0])
