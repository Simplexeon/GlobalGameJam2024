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
var closest_vertex : Vertex = null;


# Component Vars
@onready var BodySprite : Sprite3D = $Body;
@onready var RegularCollider : CollisionShape3D = $NormalCollision;
@onready var StapledCollider : CollisionShape3D = $StapledCollision;
@onready var VertexChecker : Area3D = $VertexChecker;


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
	print(move_dir)
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

func updateVertex() -> void:
	var vertices : Array = VertexChecker.get_overlapping_areas();
	for vertex in vertices:
		if(closest_vertex == null):
			closest_vertex = vertex;
		if(global_position.distance_to(vertex.global_position) < global_position.distance_to(closest_vertex.global_position)):
			closest_vertex = vertex;
