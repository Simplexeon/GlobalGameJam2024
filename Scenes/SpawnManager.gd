extends Node3D

@onready var enemies : Array = [preload("res://Scenes/Enemies/enemy.tscn")];

var doors : Array;

# Called when the node enters the scene tree for the first time.
func _ready():
	doors = get_children();
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func Spawn(doorIndex : int, enemyIndex : int):
	var enemy : Enemy = enemies[enemyIndex].instantiate();
	get_tree().root.add_child(enemy);
	enemy.global_position = doors[doorIndex].global_position;
	pass
