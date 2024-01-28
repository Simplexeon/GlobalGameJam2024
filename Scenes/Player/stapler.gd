extends Sprite3D
class_name Stapler

# Export Vars
@export var BulletSpeed : float;
@export var Cooldown : float;

# Object Vars
var player_velocity : Vector3 = Vector3.ZERO;

# Component Vars
@onready var CD : Timer = $CD;
@onready var StapleSpawn : Node3D = $StapleSpawn;
@onready var StapleDir : Node3D = $StapleSpawn/StapleDir;
@onready var Animator : AnimationPlayer = get_parent().get_node("AnimationPlayer");
var root : Node3D;
@onready var Sounds : AudioStreamPlayer3D = $Sounds;

# File Vars
@onready var staple_file : PackedScene = preload("res://Scenes/Bullets/staple.tscn");


# Processes

func _ready() -> void:
	root = get_tree().current_scene;
	CD.wait_time = Cooldown;
	frame = 0;

func _physics_process(delta: float) -> void:
	if(Input.is_action_just_pressed("shoot")):
		shoot();


# Functions

func shoot() -> void:
	if(!CD.is_stopped()):
		return;
	
	var staple : Staple = staple_file.instantiate();
	root.add_child(staple);
	staple._initialize(StapleSpawn.global_position, StapleDir.global_position, BulletSpeed + player_velocity.length());
	frame = 3;
	Sounds.play();
	Animator.play("Shoot", 0.05, 1);
	
	CD.start();
