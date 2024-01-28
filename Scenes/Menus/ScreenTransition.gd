extends Node2D
class_name  TransitionNode


# Export var
@export var FadeIn : bool;
@export var TransitionType : Transitions;
@export var Autoplay : bool = false;

# Enums

enum Transitions {
	Rainbow,
	Hands
}

# Component Vars
@onready var Animator : AnimationPlayer = $AnimationPlayer;
#region Transition Nodes
@onready var HandsTrans : Sprite2D = $HandsTransition;
@onready var RainbowTrans : Sprite2D = $RainbowTransition;
#endregion

# Processes

func _ready() -> void:
	match(TransitionType):
		Transitions.Rainbow:
			RainbowTrans.visible = true;
			HandsTrans.visible = false;
		Transitions.Hands:
			HandsTrans.visible = true;
			RainbowTrans.visible = false;
	
	if(FadeIn):
		Animator.speed_scale = -1;
	
	if(Autoplay):
		call_deferred("go");

func initialize(start_pos : Vector2, fade_in : bool, transition_type : int) -> void:
	
	global_position = start_pos;
	FadeIn = fade_in;
	TransitionType = transition_type as Transitions;
	
	match(TransitionType):
		Transitions.Rainbow:
			RainbowTrans.visible = true;
			HandsTrans.visible = false;
		Transitions.Hands:
			HandsTrans.visible = true;
			RainbowTrans.visible = false;
	
	if(FadeIn):
		Animator.speed_scale = -1;
	
	go();

# Functions

func go() -> void:
	match(TransitionType):
		Transitions.Rainbow:
			Animator.play("RainbowTrans", 0, 1.0, FadeIn);
		Transitions.Hands:
			Animator.play("HandsTrans", 0, 1.0, FadeIn);



func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	queue_free();
