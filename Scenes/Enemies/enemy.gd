extends CharacterBody3D
class_name Enemy

# Export Vars
@export var Speed : float;
@export var HP : int;
@export var StapleSpeed : float;
@export var StapleHeightOffset : float;
@export var FindNextPoint : float;
@export var GrabDistance : float;
@export var GrabSpeed : float;
@export var GrabScale : float;

# Object Vars
var move_dir : Vector3 = Vector3.ZERO;
var stapled : bool = false;
var stuck : bool = false;
var gravity : float = ProjectSettings.get_setting("physics/3d/default_gravity");
var next_path_pos = Vector3.ZERO;
var hand_offset : Vector3 = Vector3.ZERO;

# Lambdas
var MoveState = moveNormal;


# Component Vars
@onready var BodySprite : Sprite3D = $Body;
@onready var RegularCollider : CollisionShape3D = $NormalCollision;
@onready var StapledCollider : CollisionShape3D = $StapledCollision;
@onready var VertexChecker : VertexChecker3D = $VertexChecker;
@onready var BloodParticles : CPUParticles3D = $CPUParticles3D;
@onready var HandSprite : Sprite3D = $Body/Hands;
@onready var PlayerRaycast : RayCast3D = $PlayerRaycast;
@onready var GrabBox : Area3D = $Body/Hands/GrabBox;
var player : CharacterBody3D;
var graph : Graph;


# Processes

func _ready() -> void:
	graph = get_tree().get_first_node_in_group("Graph");
	MoveState = moveNormal;
	player= get_tree().get_first_node_in_group("Player");

func _physics_process(delta: float) -> void:
	if(stuck):
		return;
	
	if(player != null):
		var player_vector : Vector3 = (player.global_position - global_position);
		if(player_vector.length() <= GrabDistance):
			var next_pos : Vector3 = (player.global_position - HandSprite.global_position).normalized() * GrabSpeed * delta;
			HandSprite.position += next_pos;
			hand_offset += next_pos;
			HandSprite.scale += Vector3(GrabScale * delta, GrabScale * delta, GrabScale * delta);
		else:
			HandSprite.position -= hand_offset;
			hand_offset = Vector3.ZERO;
			HandSprite.scale = Vector3(1.5, 1.5, 1.5);
	
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
		
		global_position = collision.get_position(0);
		stuck = true;
		BodySprite.billboard = BaseMaterial3D.BILLBOARD_DISABLED;
		BodySprite.look_at(collision.get_normal() * 500);
		HandSprite.billboard = BaseMaterial3D.BILLBOARD_DISABLED;
		HandSprite.look_at(collision.get_normal() * 500);
		StapledCollider.set_deferred("disabled", true);

func _on_Stapled(staple_pos : Vector3) -> void:
	var target_pos : Vector3 = staple_pos;
	if(player != null):
		target_pos = player.global_position;
	move_dir = ((target_pos) - global_position).normalized();
	move_dir -= Vector3(0, move_dir.y + StapleHeightOffset, 0);
	move_dir = move_dir.normalized();
	move_dir = move_dir * -1;
	BodySprite.billboard = BaseMaterial3D.BILLBOARD_DISABLED;
	BodySprite.look_at(move_dir * 500);
	HandSprite.billboard = BaseMaterial3D.BILLBOARD_DISABLED;
	HandSprite.look_at(move_dir * 500);
	StapledCollider.look_at(move_dir * 500);
	stapled = true;
	RegularCollider.set_deferred("disabled", true);
	StapledCollider.set_deferred("disabled", false);
	BloodParticles.emitting = true;
	MoveState = moveStapled;
	GrabBox.monitoring = false;
	GrabBox.monitorable = false;

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
	if(player != null):
		BodySprite.look_at(player.global_position);
		PlayerRaycast.target_position = player.global_position - PlayerRaycast.global_position;
		if(PlayerRaycast.is_colliding()):
			if(PlayerRaycast.get_collider() is Player):
				MoveState = movePlayer;
	rotation_degrees.x = 0;
	rotation_degrees.z = 0; 
	
	if(!is_on_floor()):
		velocity += Vector3(0, gravity * -1, 0);
	

func moveStapled() -> void:
	velocity = move_dir * StapleSpeed;

func movePlayer() -> void:
	if(player == null):
		MoveState = moveNormal;
		return;
	
	var target_dir = player.global_position - global_position;
	target_dir = target_dir - Vector3(0, target_dir.y, 0);
	target_dir = target_dir.normalized();
	
	velocity = target_dir * Speed;
	
	BodySprite.look_at(player.global_position);
	PlayerRaycast.target_position = player.global_position - PlayerRaycast.global_position;
	if(!PlayerRaycast.is_colliding()):
		MoveState = moveNormal;
	elif(!PlayerRaycast.get_collider().is_in_group("Player")):
		MoveState = moveNormal;


