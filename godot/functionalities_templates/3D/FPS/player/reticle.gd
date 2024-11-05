extends CenterContainer

class_name Reticle

@onready var reticle_texture: TextureRect = %ReticleTexture
var default_texture: Texture2D


func _ready() -> void:
	default_texture = reticle_texture.texture


func update_texture(texture: Texture2D) -> void:

	if texture:
		reticle_texture.texture = texture
	else:
		reticle_texture.texture = default_texture
