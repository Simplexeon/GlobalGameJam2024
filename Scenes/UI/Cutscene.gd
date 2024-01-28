extends VideoStreamPlayer

@onready var DeathTimer : Timer = $Timer;

func _on_CutsceneBegin() -> void:
	play();
	DeathTimer.start();
	#endCutscene();


func endCutscene() -> void:
	get_tree().call_group("CBegin", "_on_Begin");


func _on_finished():
	get_tree().call_group("CBegin", "_on_Begin");
	queue_free();


func _on_timer_timeout():
	_on_finished();
