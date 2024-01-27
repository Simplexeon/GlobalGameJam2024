@tool
extends CharacterBody3D
class_name Enemy

# Export Vars
@export var Speed : float;
@export var HP : int;
@export var StapleSpeed : float;

# Object Vars
var move_dir : Vector3 = Vector3.ZERO;
var stapled : bool = false;
var stuck : bool = false;


# Component Vars
@onready var BodySprite : Sprite3D = $Body;
@onready var RegularCollider : CollisionShape3D = $NormalCollision;
@onready var StapledCollider : CollisionShape3D = $StapledCollision;


# Processes

func _physics_process(delta: float) -> void:
	if(stuck):
		return;
	if(stapled):
		moveStapled();
	else:
		moveNormal();
	
	move_and_slide();
	
	var collision : KinematicCollision3D = get_last_slide_collision();
	if(collision != null):
		if(collision.get_collider().is_in_group("Enemies")):
			return;
		stuck = true;
		BodySprite.billboard = BaseMaterial3D.BILLBOARD_DISABLED;
		BodySprite.look_at(collision.get_normal());

func _on_Stapled(staple_pos : Vector3) -> void:
	move_dir = (staple_pos - global_position).normalized();
	move_dir = move_dir * -1;
	BodySprite.billboard = BaseMaterial3D.BILLBOARD_ENABLED;
	stapled = true;
	RegularCollider.set_deferred("disabled", true);
	StapledCollider.set_deferred("disabled", false);


# Functions

func moveNormal() -> void:
	pass;

func moveStapled() -> void:
	velocity = move_dir * StapleSpeed;
