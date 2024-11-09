class_name InteractionComponent extends Node

## Base class for interactable components.
## It adds the signals and connects them to the parent node.
## It also handles the interaction logic.
## Signals: focused, unfocused, interacted, interaction_finished

var parent: Node
var focus_texture: Texture2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	parent = get_parent()
	connect_parent()
	

func _on_focus() -> void:
	print("InteractionComponent: on focus")
	print(parent.name)
	# update_reticle_sprite(focus_texture)


func _on_unfocus() -> void:
	print("InteractionComponent: on unfocus")
	# update_reticle_sprite(unfocus_texture)


func _on_interact() -> void:
	print("InteractionComponent: on interact")


func _on_interaction_finished() -> void:
	print("InteractionComponent: on interaction finished")



func connect_parent() -> void:
	parent.add_user_signal("focused")
	parent.add_user_signal("unfocused")
	parent.add_user_signal("interacted")
	parent.add_user_signal("interaction_finished")

	parent.connect("focused", _on_focus)
	parent.connect("unfocused", _on_unfocus)
	parent.connect("interacted", _on_interact)
	parent.connect("interaction_finished", _on_interaction_finished)


func disconnect_signals() -> void:
	parent.remove_user_signal("interacted")


# func update_reticle_sprite(texture: Texture2D) -> void:
# 	Global.player.update_reticle(texture)
