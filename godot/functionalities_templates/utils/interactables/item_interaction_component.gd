class_name ItemInteractionComponent extends InteractionComponent

## Component to add interaction to an object.
## The first child must be the node model containing the mesh. The mesh must be the first child of that node.
## It uses Dialogic to start a timeline and, if received a "remove_interactable" signal from Dialogic, it will be removed. 

@export var outline_thickness: float = 0.006
@export var timeline_name: String = "timeline"
@export var object_mesh: MeshInstance3D
@export var animation_name: String = "interaction"
@export var default_focus_texture: Texture2D = preload("res://assets/art/kenney_cursor_pack/PNG/Basic/Double/zoom.png")

var mark_for_deletion: bool = false
var can_iteract: bool = true
var animation_player: AnimationPlayer
var mesh: MeshInstance3D

signal item_collected

func _ready() -> void:
	super()

	# set the reticule textures
	focus_texture = default_focus_texture

	# set the animation player
	if parent.has_node("AnimationPlayer"):
		animation_player = parent.get_node("AnimationPlayer")
	
	# get the mesh instance from parent node
	# get children of parent with type MeshInstance3D
	mesh = parent.find_children("*", "MeshInstance3D", true)[0]
	if mesh:
		mesh.material_overlay = PreloadedMaterials.interactable_focus_highlight
		(mesh.material_overlay as ShaderMaterial).set_shader_parameter("enabled", false)
	

	# var original_mesh: MeshInstance3D = object_mesh
	# assert (original_mesh is MeshInstance3D)

	# # create the outline mesh 

	# # load the material for the outline mesh
	# var surface_outline_material: StandardMaterial3D = load("res://assets/materials/outline_mesh_material_3d.tres") as StandardMaterial3D

	# # create the MeshInstance3D for the outline mesh
	# outline_mesh_instance = MeshInstance3D.new()
	# outline_mesh_instance.mesh = outline_mesh
	# outline_mesh_instance.material_override = surface_outline_material
	# outline_mesh_instance.visible = false

	# # add the outline mesh to the original_mesh node
	# original_mesh.add_child(outline_mesh_instance)



func _on_focus() -> void:
	super()
	if mesh:
		(mesh.material_overlay as ShaderMaterial).set_shader_parameter("enabled", true)
	# outline_mesh_instance.visible = true


func _on_unfocus() -> void:
	super()
	if mesh:
		(mesh.material_overlay as ShaderMaterial).set_shader_parameter("enabled", false)
	# outline_mesh_instance.visible = false


func _on_interact() -> void:
	super()
	# TODO fix the first instantiation of the timeline
	Dialogic.timeline_ended.connect(_on_timeline_ended)
	Dialogic.signal_event.connect(_on_signal_event)
	Dialogic.start(timeline_name)


func _on_interaction_finished() -> void:
	super()
	Dialogic.timeline_ended.disconnect(_on_timeline_ended)
	Dialogic.signal_event.disconnect(_on_signal_event)


func disconnect_signals() -> void:
	super()


func _on_timeline_ended() -> void:
	parent.emit_signal("interaction_finished")

	if mark_for_deletion:
		item_collected.emit(parent)
		# Global.player.interact_cast_result = null
		# update_reticle_sprite(unfocus_texture)
		parent.queue_free()

	# play the final animation if the item can't be iteracted with anymore
	if not can_iteract:
		if animation_player:
			animation_player.play(animation_name)


func _on_signal_event(event:String, _resource:String) -> void:
	if event == "remove_interactable":
		mark_for_deletion = true
	if event == "conclude_interaction":
		# if the interaction is concluded play a final animation 
		# and disable the interaction
		can_iteract = false
		disconnect_signals()
