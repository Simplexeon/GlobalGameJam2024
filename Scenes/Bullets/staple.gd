extends RigidBody3D
class_name Staple


# Processes

func _initialize(spawn_pos : Vector3, spawn_dir : Vector3, speed : float) -> void:
	global_position = spawn_pos;
	look_at(spawn_dir);
	linear_velocity = (spawn_dir - spawn_pos).normalized() * speed;

func _on_hitbox_body_entered(_body: Node3D) -> void:
	sleeping = true;
