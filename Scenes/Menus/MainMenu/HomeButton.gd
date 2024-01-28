@tool
extends TextureButton

# Export Vars
@export var CenterOffset : Vector2;


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
	var Transition : TransitionNode = Globals.transition_file.instantiate();
	add_child(Transition);
	Transition.initialize(Vector2(500, 350), false, 0);
	Transition.Animator.connect("animation_finished", transition_end);

func transition_end(anim_name : StringName) -> void:
	get_tree().change_scene_to_packed(Globals.main_menu);
