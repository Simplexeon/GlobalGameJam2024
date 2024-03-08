extends Node3D
class_name Door3D

# Object Vars
var queued_enemies : int = 0;

# Component Vars
@onready var Sprite : Sprite3D = $Sprite3D;
@onready var EnemySpawnPos : Node3D = $EnemySpawnPos;
@onready var Animator : AnimationPlayer = $AnimationPlayer;

# File Vars
@onready var enemies : Array = [preload("res://Scenes/Enemies/enemy.tscn")];

# Processes

func _ready() -> void:
	Sprite.rotation.y = 0;

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if(anim_name == "Open"):
		Animator.play("SpawnGuy"); # TODO spawn enemy
	if(anim_name == "SpawnGuy"):
		spawnEnemy();
		queued_enemies -= 1;
		if(queued_enemies > 0):
			Animator.play("SpawnGuy");
		else:
			Animator.play("Close");

# Functions

func queueEnemy() -> void:
	if(queued_enemies == 0):
		Animator.play("Open"); # TODO ADD ANIMATION
	queued_enemies += 1;

func spawnEnemy() -> void:
	var enemy : Enemy = enemies[0].instantiate();
	get_tree().root.add_child(enemy);
