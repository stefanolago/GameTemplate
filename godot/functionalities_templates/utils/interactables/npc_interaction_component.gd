class_name NPCInteractionComponent extends InteractionComponent

## Component to add an interaction to an NPC.

@export var timeline_name: String = "timeline"
@export var default_focus_texture: Texture2D = preload("res://assets/art/icons/kenney_cursor_pack/PNG/Basic/Double/message_dots_round.png")

var sprite: Sprite3D
var outline_shader_material: ShaderMaterial

func _ready() -> void:
	super()
	
	# set the reticule textures
	focus_texture = default_focus_texture

	Dialogic.timeline_ended.connect(_on_timeline_ended)
	
	# # get the sprite from parent node

	# sprite = parent.get_node("Sprite3D")
	# assert(sprite != null)

	# # load the shader
	# outline_shader_material = load("res://assets/materials/npc_outline_shader_material.tres")
	# outline_shader_material.resource_local_to_scene = true
	# # set the property sprite texture in outline shader material to be the same sprite texture as the parent sprite
	# outline_shader_material.set_shader_parameter("sprite_texture", sprite.texture)
	# # set the property line weight in outline shader material
	# outline_shader_material.set_shader_parameter("lineWeight", 5.0)


func _on_focus() -> void:
	super()
	# apply the shader to the sprite as a material overlay
	# sprite.material_overlay = outline_shader_material


func _on_unfocus() -> void:
	super()
	# apply the shader to the sprite as a material overlay
	# sprite.material_overlay = null


func _on_interact() -> void:
	super()
	# TODO fix the first instantiation of the timeline
	Dialogic.start(timeline_name)


func _on_interaction_finished() -> void:
	super()


func _on_timeline_ended() -> void:
	parent.emit_signal("interaction_finished")
