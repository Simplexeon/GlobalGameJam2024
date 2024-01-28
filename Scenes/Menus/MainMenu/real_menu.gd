extends Node2D

#Files
@onready var trans_file = preload("res://Scenes/Menus/ScreenTransition.tscn");


func _ready() -> void:
	var Transition : TransitionNode = trans_file.instantiate();
	add_child(Transition);
	Transition.call_deferred("initialize", Vector2(500, 350), true, 1);

func _on_Transition() -> void:
	var Transition : TransitionNode = Globals.transition_file.instantiate();
	add_child(Transition);
	Transition.initialize(Vector2(500, 350), false, 0);
	Transition.Animator.connect("animation_finished", transition_end);

func transition_end(anim_name : StringName) -> void:
	get_tree().change_scene_to_packed(ResourceLoader.load_threaded_get(Globals.game_file));
