extends Node3D


func _ready():
	get_tree().call_group("CCutsceneBegin", "_on_CutsceneBegin");
