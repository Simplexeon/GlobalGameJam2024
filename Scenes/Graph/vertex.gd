@tool
extends Node3D

class_name Vertex

@onready var Sprite : Sprite3D = $Sprite3D;

# Called when the node enters the scene tree for the first time.
func _ready():
	vertexPosition = global_position;
	Reset();
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(!Engine.is_editor_hint()):
		Sprite.visible = false
	pass
	

var vertexPosition : Vector3;

var permanent : bool:
	set(value):
		pass;
	get: 
		return permanent;
		pass;

var previousVertex : Vertex:
	set(value):
		pass;
	get: 
		return previousVertex;
		pass;

var distance : float:
	set(value):
		pass;
	get: 
		return distance;
		pass;

func Reset():
	distance = 1000000;
	permanent = false;
	previousVertex = null;
