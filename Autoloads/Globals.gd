extends Node


var last_run_time : float = 9999.99;

var game_file : String = "res://Scenes/Levels/test.tscn";


# Processes

func _ready() -> void:
	ResourceLoader.load_threaded_request(game_file);
