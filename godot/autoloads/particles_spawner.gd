class_name ParticleSpawner extends Node

@export var particles: Array[PackedScene]

var particles_dict: Dictionary

func _ready() -> void:
	for i: int in particles.size():
		var particle_scene: PackedScene = particles[i]
		if not particle_scene:
			continue
		var scene_path: String = particle_scene.resource_path
		var preload_scene: PackedScene = load(scene_path)
		var particle_name: String = scene_path.split("/")[-1].split(".")[0]
		particles_dict[particle_name] = preload_scene

func spawn_one_off_2D(particle_name: String, position: Vector2, parent: Node = null) -> void:
	var particle_path: PackedScene = particles_dict.get(particle_name)
	if not particle_path:
		push_warning("Particle %s not found" %particle_name)
		return
	var particle_instance: Node = particle_path.instantiate()
	if particle_instance is not GPUParticles2D:
		push_warning("Particle %s root is not GPUParticles2D, can't spawn" %particle_name)
		return
	(particle_instance as GPUParticles2D).global_position = position
	var parent_scene: Node = parent
	if not parent_scene:
		parent_scene = self
	parent_scene.add_child.call_deferred(particle_instance)
	(particle_instance as GPUParticles2D).emitting = true
	(particle_instance as GPUParticles2D).finished.connect(particle_instance.queue_free)
