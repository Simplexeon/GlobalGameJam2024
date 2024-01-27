extends CharacterBody3D
class_name Enemy

# Export Vars
@export var Speed : float;
@export var HP : int;
@export var StapleSpeed : float;
@export var StapleHeightOffset : float;
@export var FindNextPoint : float;

# Object Vars
var move_dir : Vector3 = Vector3.ZERO;
var stapled : bool = false;
var stuck : bool = false;
var gravity : float = ProjectSettings.get_setting("physics/3d/default_gravity");
var next_path_pos = Vector3.ZERO;

# Lambdas
var MoveState = moveNormal;


# Component Vars
@onready var BodySprite : Sprite3D = $Body;
@onready var RegularCollider : CollisionShape3D = $NormalCollision;
@onready var StapledCollider : CollisionShape3D = $StapledCollision;
@onready var VertexChecker : VertexChecker3D = $VertexChecker;
@onready var BloodParticles : CPUParticles3D = $CPUParticles3D;
var graph : Graph;


# Processes

func _ready() -> void:
	graph = get_tree().get_first_node_in_group("Graph");
	MoveState = moveNormal;

func _physics_process(delta: float) -> void:
	if(stuck):
		return;
	
	MoveState.call();
	
	move_and_slide();
	
	if(get_slide_collision_count() < 1):
		return;
	var collision : KinematicCollision3D = get_slide_collision(0);
	if(collision != null and stapled):
		if(collision.get_collider() == null):
			return;
		if(collision.get_collider().is_in_group("Enemies")):
			return;
		if(collision.get_collider().is_in_group("Staples")):
			return;
		
		stuck = true;
		BodySprite.billboard = BaseMaterial3D.BILLBOARD_DISABLED;
		BodySprite.look_at(collision.get_normal() * 500);
		StapledCollider.set_deferred("disabled", true);

func _on_Stapled(staple_pos : Vector3) -> void:
	move_dir = ((staple_pos) - global_position).normalized();
	move_dir -= Vector3(0, move_dir.y + StapleHeightOffset, 0);
	move_dir = move_dir.normalized();
	move_dir = move_dir * -1;
	BodySprite.billboard = BaseMaterial3D.BILLBOARD_DISABLED;
	BodySprite.look_at(move_dir);
	stapled = true;
	RegularCollider.set_deferred("disabled", true);
	StapledCollider.set_deferred("disabled", false);
	BloodParticles.emitting = true;
	MoveState = moveStapled;

func _on_update_movement_timeout() -> void:
	VertexChecker.updateVertex();
	if(VertexChecker.closest_vertex == null):
		return;
	if(VertexChecker.closest_vertex.previousVertex == null):
		return;
	next_path_pos = VertexChecker.closest_vertex.previousVertex.global_position;

# Functions

func moveNormal() -> void:
	velocity = Vector3.ZERO;
	
	var target_vector : Vector3 = (next_path_pos - global_position);
	target_vector -= Vector3(0, target_vector.y, 0);
	target_vector = target_vector.normalized() * Speed;
	
	
	if((next_path_pos - (global_position + target_vector)).length() <= FindNextPoint):
		_on_update_movement_timeout();
	
	velocity += target_vector;
	
	if(!is_on_floor()):
		velocity += Vector3(0, gravity * -1, 0);
	

func moveStapled() -> void:
	velocity = move_dir * StapleSpeed;




