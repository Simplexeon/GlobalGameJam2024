extends Area3D

# Object Vars
var closest_vertex : Vertex = null;


# Functions

func updateVertex() -> void:
	var vertices : Array = get_overlapping_areas();
	for vertex in vertices:
		if(closest_vertex == null):
			closest_vertex = vertex;
		if(global_position.distance_to(vertex.global_position) < global_position.distance_to(closest_vertex.global_position)):
			closest_vertex = vertex;
