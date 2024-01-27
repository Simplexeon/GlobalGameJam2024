extends Sprite2D


# Export Vars
@export var StartStyle : float;
@export var StyleDecay : float;
@export var KillMessages : Array[String];

# Object Vars
var current_style : float = 0.0 :
	set(value):
		current_style = clampf(value, 0.0, 100.0);
		region_rect = Rect2(0, 0, int((texture.get_width() - 1) * (current_style / 100.0)), 100)

# Component Vars
@onready var KillFeed : VBoxContainer = $KillFeed;

# File Vars
@onready var kill_message_file : PackedScene = preload("res://Scenes/UI/HUD/kill_message.tscn");


# Processes

func _ready() -> void:
	current_style = StartStyle;

func _physics_process(delta: float) -> void:
	current_style -= StyleDecay * delta;
	
	if(Input.is_action_just_pressed("test_kill")):
		_on_EnemyDied("Stephen", randf_range(10.0, 30.0));

func _on_EnemyDied(enemy_name : String, points : float) -> void:
	current_style += points;
	
	var KillMessage : RichTextLabel = kill_message_file.instantiate();
	KillMessage.initialize(points, enemy_name, KillMessages[randi_range(0, KillMessages.size() - 1)]);
	KillFeed.add_child(KillMessage);
	
