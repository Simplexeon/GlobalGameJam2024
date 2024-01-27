extends RichTextLabel


# Processes

func initialize(points : float, enemy_name : String, message : String) -> void:
	text = " + %2d | %s %s" % [int(points), enemy_name, message];

func _on_death_timer_timeout() -> void:
	queue_free();
