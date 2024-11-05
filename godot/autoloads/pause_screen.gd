extends CanvasLayer


@export var blur_amount_when_paused: float = 2.0

@onready var options_menu: OptionsMenu = $OptionsMenu
@onready var shader_material: ShaderMaterial = ($BlurringBackground as ColorRect).material

var mouse_mode_before_pause: Input.MouseMode = Input.MouseMode.MOUSE_MODE_VISIBLE 
var game_is_paused: bool = false:
	set(value):
		game_is_paused = value
		if game_is_paused:
			mouse_mode_before_pause = Input.mouse_mode
			Input.mouse_mode = Input.MouseMode.MOUSE_MODE_VISIBLE

			options_menu.focus_first_available_control()
		else:
			Input.mouse_mode = mouse_mode_before_pause


		options_menu.visible = game_is_paused
		get_tree().paused = game_is_paused
		shader_material.set_shader_parameter("lod", blur_amount_when_paused if game_is_paused else 0.0)


func _ready() -> void:
	options_menu.visible = false
	shader_material.set_shader_parameter("lod", 0.0)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		var current_scene_name: String = get_tree().current_scene.name
		if current_scene_name == "StartMenu" or current_scene_name == "StartScreen":
			return
		game_is_paused = !game_is_paused
