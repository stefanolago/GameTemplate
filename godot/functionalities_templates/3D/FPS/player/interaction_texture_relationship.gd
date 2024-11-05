class_name InteractionTextureRelationship extends Resource


enum InteractionType {
	NONE,
	ITEM,
	OBJECT,
	NPC
}


@export var interaction_type: InteractionType
@export var texture: Texture2D