@tool
extends TextureButton

# Export Vars
@export var CenterOffset : Vector2;

# File Vars
@onready var game_file : PackedScene = preload("res://Scenes/Testing/main.tscn");
@onready var transition_file : PackedScene = preload("res://ReusableScenes/UI/Transitions/screen_transition.tscn");


# Processes

func _process(delta: float) -> void:
	if(Engine.is_editor_hint() == false):
		return;
	anchors_preset = PRESET_CENTER;
	anchor_bottom = 0.5;
	anchor_top = 0.5;
	anchor_left = 0.5;
	anchor_right = 0.5;
	position += CenterOffset;


func _on_pressed() -> void:
	GlobalParameters.played_once = true;
	var Transition : TransitionNode = transition_file.instantiate();
	get_tree().root.add_child(Transition);
	Transition.global_position = Vector2(400, 400);
	Transition.initialize(false);
	Transition.Animator.connect("animation_finished", changeScene);


func changeScene(_anim_name) -> void:
	get_tree().change_scene_to_packed(game_file);


