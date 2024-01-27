@tool
extends CharacterBody3D
class_name Enemy

# Export Vars
@export var Speed : float;
@export var HP : int;
@export var StapleSpeed : float;
@export var StapleHeightOffset : float;

# Object Vars
var move_dir : Vector3 = Vector3.ZERO;
var stapled : bool = false;
var stuck : bool = false;
var gravity : float = ProjectSettings.get_setting("physics/3d/default_gravity");


# Component Vars
@onready var BodySprite : Sprite3D = $Body;
@onready var RegularCollider : CollisionShape3D = $NormalCollision;
@onready var StapledCollider : CollisionShape3D = $StapledCollision;


# Processes

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	if(stuck):
		return;
	if(stapled):
		moveStapled();
	else:
		moveNormal();
	
	move_and_slide();
	
	var collision : KinematicCollision3D = get_last_slide_collision();
	if(collision != null and stapled):
		if(collision.get_collider().is_in_group("Enemies")):
			return;
		if(collision.get_collider().is_in_group("Staples")):
			return;
		
		stuck = true;
		BodySprite.billboard = BaseMaterial3D.BILLBOARD_DISABLED;
		BodySprite.look_at(collision.get_normal() * 500);
		

func _on_Stapled(staple_pos : Vector3) -> void:
	move_dir = ((staple_pos - Vector3(0, StapleHeightOffset, 0)) - global_position).normalized();
	move_dir = move_dir * -1;
	BodySprite.billboard = BaseMaterial3D.BILLBOARD_DISABLED;
	BodySprite.look_at(move_dir);
	stapled = true;
	RegularCollider.set_deferred("disabled", true);
	StapledCollider.set_deferred("disabled", false);


# Functions

func moveNormal() -> void:
	velocity = Vector3.ZERO;
	if(!is_on_floor()):
		velocity = Vector3(0, gravity * -1, 0);

func moveStapled() -> void:
	velocity = move_dir * StapleSpeed;
