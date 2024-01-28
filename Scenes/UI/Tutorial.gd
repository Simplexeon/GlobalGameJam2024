extends Sprite2D

# Component vars
@onready var TimeLeft : Timer = $Timer;


# Process

func _physics_process(delta: float) -> void:
	if(TimeLeft.time_left < 3):
		modulate.a = TimeLeft.time_left / 3;


func _on_timer_timeout() -> void:
	queue_free();
