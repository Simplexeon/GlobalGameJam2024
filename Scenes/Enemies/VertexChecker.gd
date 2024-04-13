extends Area3D
class_name VertexChecker3D

# Object Vars
var closest_vertex : Vertex = null;


# Functions

func updateVertex() -> Vertex:
	var vertices : Array = get_overlapping_areas();
	var updated : bool = false;
	for vertex in vertices:
		if(!updated):
			closest_vertex = vertex;
			updated = true;
		if(global_position.distance_to(vertex.global_position) < global_position.distance_to(closest_vertex.global_position)):
			closest_vertex = vertex;
	
	return closest_vertex;
