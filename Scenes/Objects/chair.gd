extends RigidBody3D


# Processes

func _on_area_3d_body_entered(body: Node3D) -> void:
	if(body is Player):
		apply_impulse((body.global_position - global_position) * -1 * body.current_speed, body.global_position)
	if(body is Enemy):
		apply_impulse((body.global_position - global_position) * -1 * body.Speed, body.global_position)
	if(body is Staple):
		apply_impulse((body.global_position - global_position) * -1 * 6.5, body.global_position)
