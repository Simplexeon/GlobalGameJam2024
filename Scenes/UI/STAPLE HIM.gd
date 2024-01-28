extends Node2D

@onready var STAPLE : Sprite2D = $STAPLE;
@onready var Him : Sprite2D = $HIM
@onready var Sound : AudioStreamPlayer = $Sound;


func _on_timer_timeout() -> void:
	Him.visible = !Him.visible

func _on_GameStart() -> void:
	queue_free();

func _on_sound_finished() -> void:
	Sound.play();

func _on_Begin() -> void:
	STAPLE.visible = true;
	Sound.play();
