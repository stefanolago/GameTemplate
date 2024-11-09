class_name Player3D extends CharacterBody3D


@onready var camera_controller: Node3D = $CameraController
@onready var camera: Camera3D = $CameraController/Camera3D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var state_machine: StateMachine = $PlayerStateMachine
@onready var hand: Node3D = $Hand
@onready var torch: SpotLight3D = %Torch
@onready var reticle: Reticle = %Reticle
@onready var footstep_raycast: RayCast3D = $footstep_raycast

@export var mouse_sensitivity: float = 0.5
@export var tilt_lower_limit: float = deg_to_rad(-90.0)
@export var tilt_upper_limit: float = deg_to_rad(90.0)
## How far the player can interact.
@export var interact_distance: float = 2.0

var mouse_input: bool = false
var mouse_rotation: Vector3 = Vector3.ZERO
var rotation_input: float = 0.0
var tilt_input: float = 0.0
var player_rotation: Vector3
var camera_rotation: Vector3
var interact_cast_result: Node
var floor_type: int = 2

# starting position of player
var starting_position: Vector3

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	starting_position = global_position


func _physics_process(delta: float) -> void:
	update_camera(delta)
	interact_cast()


func _unhandled_input(event: InputEvent) -> void:
	mouse_input = event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED
	if mouse_input:
		rotation_input = -(event as InputEventMouseMotion).relative.x * mouse_sensitivity
		tilt_input = -(event as InputEventMouseMotion).relative.y * mouse_sensitivity


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("exit"):
		get_tree().quit()
	# if event.is_action_pressed("mouse_capture_toggle"):
	# 	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
	# 		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	# 	else:
	# 		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func update_input(speed: float, acceleration: float, deceleration: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir: Vector2 = Input.get_vector("left", "right", "up", "down")
	var direction: Vector3 = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = lerp(velocity.x, direction.x * speed, acceleration)
		velocity.z = lerp(velocity.z, direction.z * speed, acceleration)
	else:
		velocity.x = move_toward(velocity.x, 0, deceleration)
		velocity.z = move_toward(velocity.z, 0, deceleration)


func update_gravity(delta: float) -> void:
	velocity += get_gravity() * delta


func update_velocity() -> void:
	move_and_slide()


func update_camera(delta: float) -> void:

	# VERTICAL

	mouse_rotation.x += tilt_input * delta
	mouse_rotation.x = clamp(mouse_rotation.x, tilt_lower_limit, tilt_upper_limit)
	camera_rotation = Vector3(mouse_rotation.x, 0.0, 0.0)
	camera.transform.basis = Basis.from_euler(camera_rotation)
	camera.rotation.z = 0.0


	# HORIZONTAL
	mouse_rotation.y += rotation_input * delta
	player_rotation = Vector3(0.0, mouse_rotation.y, 0.0)
	global_transform.basis = Basis.from_euler(player_rotation)

	rotation_input = 0.0
	tilt_input = 0.0


func interact_cast() -> void:
	var space_state: PhysicsDirectSpaceState3D = camera.get_world_3d().direct_space_state
	var screen_center: Vector2 = get_viewport().get_visible_rect().size / 2
	var origin: Vector3 = camera.project_ray_origin(screen_center)
	var end: Vector3 = origin + camera.project_ray_normal(screen_center) * interact_distance

	
	var query: PhysicsRayQueryParameters3D = PhysicsRayQueryParameters3D.create(origin, end)
	query.collide_with_bodies = true
	var result: Dictionary = space_state.intersect_ray(query)
	var current_cast_result: Node = result.get("collider")
	if current_cast_result != interact_cast_result:
		if interact_cast_result and interact_cast_result.has_user_signal("unfocused"):
			interact_cast_result.emit_signal("unfocused")

		interact_cast_result = current_cast_result

		if interact_cast_result and interact_cast_result.has_user_signal("focused"):
			interact_cast_result.emit_signal("focused")
		
		update_reticle()

func can_interact() -> bool:
	return interact_cast_result and interact_cast_result.has_user_signal("interacted")


func update_reticle() -> void:
	if reticle:
		if interact_cast_result:
			pass
			#reticle.update_texture(interact_cast_result)
		else:
			reticle.update_texture(null)


func footstep_sound() -> void:
	print("emit footstep sound")
# 	if footstep_raycast.get_collider():
# 		var collision:Area3D = footstep_raycast.get_collider()
# 		if not collision:
# 			return
# 		var parent:Node3D = collision.get_parent()
# 		var component:FloorTypeComponent = parent.get_node("FloorTypeComponent")
# 		if not component:
# 			return
# 		floor_type = component.get("floor_type")
# 	else:
# 		floor_type = 2
# 	FmodServer.play_one_shot_with_params("event:/Character/Footsteps", {"Material": floor_type})


func reset_to_initial_status() -> void:
	global_position = starting_position
	mouse_rotation = Vector3.ZERO
	update_camera(0.0)
