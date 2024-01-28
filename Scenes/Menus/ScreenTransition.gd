extends Node2D
class_name  Transition


# Export var
@export var FadeIn : bool;
@export var TransitionType : Transitions;

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
		Animator.speed_scale *= -1;
	
	go();

func initialize(start_pos : Vector2, fade_in : bool, transition_type : int) -> void:
	
	global_position = start_pos;
	FadeIn = fade_in;
	TransitionType = transition_type;
	
	match(TransitionType):
		Transitions.Rainbow:
			RainbowTrans.visible = true;
			HandsTrans.visible = false;
		Transitions.Hands:
			HandsTrans.visible = true;
			RainbowTrans.visible = false;
	
	if(FadeIn):
		Animator.speed_scale *= -1;
	
	go();

# Functions

func go() -> void:
	match(TransitionType):
		Transitions.Rainbow:
			RainbowTrans.visible = true;
			HandsTrans.visible = false;
		Transitions.Hands:
			Animator.play("HandsTrans");
