extends HBoxContainer

class_name KeybindingButton

signal change_keybinding(key: StringName)

@onready var action_name_label: Label = $ActionName
@onready var keybinding_label: Label = $Keybinding

var input_name: StringName:
	set(value):
		input_name = value
		update_content()


func update_content() -> void:
	# Update the Action name label with the input name
	action_name_label.text = input_name.capitalize()

	# Update the Keybinding label with the possible keybindings separated by /. Limit to two keybindings.
	var events: Array[InputEvent] = InputMap.action_get_events(input_name)
	var events_string: Array[String] = []
	for event: InputEvent in events:
		events_string.append(event.as_text())
	var input_string: String = " / ".join(events_string)
	keybinding_label.text = input_string


func _on_change_button_pressed() -> void:
	change_keybinding.emit(input_name)
