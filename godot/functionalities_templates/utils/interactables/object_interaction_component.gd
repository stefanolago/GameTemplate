class_name ObjectInteractionComponent extends InteractionComponent
## Interaction component for objects.
## This class is used for objects that has an interaction that involves an animation controller.
## Generally used for doors, windows, etc.
## The animation is played alternatively forward and backwards.

@export var animation_name: String = "interaction"
@export var default_focus_texture: Texture2D = preload("res://assets/art/icons/kenney_cursor_pack/PNG/Basic/Double/hand_open.png")
@export var fmod_event_forward: FmodEventEmitter3D
@export var fmod_event_reverse: FmodEventEmitter3D


var animation_player: AnimationPlayer
var play_forward_animation: bool = true

func _ready() -> void:
	super()
	
	# set the reticule textures
	focus_texture = default_focus_texture

	animation_player = parent.get_node("AnimationPlayer")


func _on_focus() -> void:
	super()


func _on_unfocus() -> void:
	super()


func _on_interact() -> void:
	super()
	if animation_player and !animation_player.is_playing():
		if play_forward_animation:
			animation_player.play(animation_name)
			if fmod_event_forward:
				fmod_event_forward.play()
		else:
			animation_player.play_backwards(animation_name)
			if fmod_event_reverse:
				fmod_event_reverse.play()
		
		play_forward_animation = !play_forward_animation

	parent.emit_signal("interaction_finished")


func _on_interaction_finished() -> void:
	super()
