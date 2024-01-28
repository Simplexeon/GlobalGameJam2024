extends Node


var last_run_time : float = 9999.99;
var wave_reached : int = 0;

var game_file : String = "res://Scenes/Levels/test.tscn";
var main_menu : PackedScene = preload("res://Scenes/Menus/MainMenu/real_menu.tscn");
var transition_file : PackedScene = preload("res://Scenes/Menus/ScreenTransition.tscn");
var death_screen : PackedScene = preload("res://Scenes/Menus/DeathScreen.tscn");


# Processes

func _ready() -> void:
	ResourceLoader.load_threaded_request(game_file);
