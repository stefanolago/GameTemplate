extends HBoxContainer

class_name KeybindingButton

signal change_keybinding(StringName)

var input_name: StringName:
	set(value):
		input_name = value
		update_content()


func update_content():
	# Update the Action name label with the input name
	$ActionName.text = input_name.capitalize()

	# Update the Keybinding label with the possible keybindings separated by /. Limit to two keybindings.
	var events = InputMap.action_get_events(input_name)
	var events_string: Array[String] = []
	for event in events:
		events_string.append(event.as_text())
	var input_string = " / ".join(events_string)
	$Keybinding.text = input_string


func _on_change_button_pressed():
	change_keybinding.emit(input_name)