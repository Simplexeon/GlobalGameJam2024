extends Area3D


# Processes


func _on_body_entered(body: Node3D) -> void:
	if(body is Player):
		get_tree().call_group("CPlayerGrabbed", "_on_PlayerGrabbed");
