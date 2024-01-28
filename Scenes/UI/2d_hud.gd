extends Node2D


# Processes

func _ready() -> void:
	call_deferred("Opening");

func Opening() -> void:
	var Transition : TransitionNode = Globals.transition_file.instantiate();
	add_child(Transition);
	Transition.initialize(Vector2(500, 350), true, 0);

func _on_PlayerGrabbed() -> void:
	var Transition : TransitionNode = Globals.transition_file.instantiate();
	add_child(Transition);
	Transition.initialize(Vector2(500, 350), false, 1);
	Transition.Animator.connect("animation_finished", transition_end);

func transition_end(anim_name : StringName) -> void:
	get_tree().change_scene_to_packed(Globals.main_menu);
