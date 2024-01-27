@tool
extends Area3D
class_name Vertex

@onready var Sprite : Sprite3D = $Sprite3D;


func _ready():
	vertexPosition = global_position;
	Reset();

func _process(_delta):
	if(!Engine.is_editor_hint()):
		Sprite.visible = false
	pass
	

var vertexPosition : Vector3;

var permanent : bool:
	set(value):
		permanent = value;
	get: 
		return permanent;

var previousVertex : Vertex:
	set(value):
		previousVertex = value;
	get: 
		return previousVertex;

var distance : float:
	set(value):
		distance = value;
	get: 
		return distance;

func Reset():
	distance = 1000000;
	permanent = false;
	previousVertex = null;
