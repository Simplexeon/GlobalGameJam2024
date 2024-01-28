extends RigidBody3D
class_name Staple


# Processes

func _initialize(spawn_pos : Vector3, spawn_dir : Vector3, speed : float) -> void:
	global_position = spawn_pos;
	look_at(spawn_dir);
	linear_velocity = (spawn_dir - spawn_pos).normalized() * speed;

func _on_body_entered(body: Node3D) -> void:
	if(body is Enemy or body is Dad):
		body._on_Stapled(global_position);
		queue_free();
	axis_lock_angular_x = false;
	axis_lock_angular_y = false;
	axis_lock_angular_z = false;
	sleeping = true;

func _on_despawn_timer_timeout() -> void:
	queue_free();
