extends Node3D

# Object Vars
var time : float = 0.0;
var doors : Array;
var next_spawn_time : float = 5.0;
var next_door : int = 0;
var next_enemy_index : int = 0;
var current_wave : int = 1;
var current_spawn_index : int = 0;
var queued_wave : bool = false;
var started : bool = false;

# JSON Formatting
# {
#	"wave_data": [
# 	[
#		[time : float, door : int],
#		[time : float, door : int]
# 	],
# 	[
#
#
# 	]
#	]
# }

var wave_data : Array;

# File Vars
@onready var enemies : Array = [preload("res://Scenes/Enemies/enemy.tscn")];
@onready var json_file : JSON = preload("res://Data/wave_data.json");


# Processes

func _ready():
	doors = get_children();var data = json_file.data;
	wave_data = data["wave_data"];
	SetNextSpawn();

func _on_GameStart() -> void:
	started = true;

func _physics_process(delta: float) -> void:
	if(!started):
		return;
	
	time += delta;
	
	if(time >= next_spawn_time):
		Spawn(next_door, next_enemy_index);
		SetNextSpawn();
	
	if(queued_wave):
		if(get_tree().get_nodes_in_group("Enemies").size() == 0):
			time = 0.0;
			current_wave += 1
			current_spawn_index = 0;
			queued_wave = false;
			get_tree().call_group("CWaveChanged", "_on_WaveChanged", current_wave);
			if(current_wave > wave_data.size()):
				get_tree().call_group("CGameWon", "_on_GameWon");
				next_spawn_time = 99.0;
			elif(current_spawn_index > wave_data[current_wave - 1].size() - 1):
				get_tree().call_group("CGameWon", "_on_GameWon");
				next_spawn_time = 99.0;
			else:
				next_spawn_time = wave_data[current_wave - 1][current_spawn_index][0];
				next_door = int(wave_data[current_wave - 1][current_spawn_index][1]);
				current_spawn_index += 1;


# Functions

func Spawn(doorIndex : int, enemyIndex : int):
	var enemy : Enemy = enemies[enemyIndex].instantiate();
	get_tree().root.add_child(enemy);
	enemy.global_position = doors[doorIndex].global_position;

func SetNextSpawn() -> void:
	if(current_spawn_index > wave_data[current_wave - 1].size() - 1):
		queued_wave = true;
		next_spawn_time = 999.0;
	else:
		next_spawn_time = wave_data[current_wave - 1][current_spawn_index][0];
		next_door = int(wave_data[current_wave - 1][current_spawn_index][1]);
		current_spawn_index += 1;
