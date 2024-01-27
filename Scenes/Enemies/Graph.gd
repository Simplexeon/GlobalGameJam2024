extends Node3D

class_name Graph

var verteces : Array : 
	set(value):
		pass;
	get: 
		return verteces;

var adjMatrix : Array[Array];

# Called when the node enters the scene tree for the first time.
func ready():
	call_deferred("deferred_ready");

func deferred_ready() -> void:
	verteces = get_children();
	adjMatrix = [];
	for i in verteces.size():
		adjMatrix.append([]);
		for j in verteces.size():
			adjMatrix[i].append(0);
			
	
	Connect();


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func AddEdge(vert1 : Vertex, vert2 : Vertex):
	#populate adjacency matrix
	var index1 : int = verteces.find(vert1);
	var index2 : int = verteces.find(vert2);
	var pathDistance : float = vert1.position.distance_to(vert2.position);
	
	adjMatrix[index1][index2] = pathDistance;
	adjMatrix[index2][index1] = pathDistance;
	
	pass

func Connect():
	# manually connect verteces
	AddEdge(verteces[0], verteces[1]);
	AddEdge(verteces[0], verteces[2]);
	AddEdge(verteces[0], verteces[6]);
	AddEdge(verteces[1], verteces[7]);
	AddEdge(verteces[1], verteces[8]);
	AddEdge(verteces[2], verteces[3]);
	AddEdge(verteces[2], verteces[22]);
	AddEdge(verteces[3], verteces[4]);
	AddEdge(verteces[4], verteces[5]);
	AddEdge(verteces[4], verteces[16]);
	AddEdge(verteces[5], verteces[6]);
	AddEdge(verteces[5], verteces[9]);
	AddEdge(verteces[7], verteces[8]);
	AddEdge(verteces[7], verteces[10]);
	AddEdge(verteces[8], verteces[9]);
	AddEdge(verteces[9], verteces[15]);
	AddEdge(verteces[10], verteces[11]);
	AddEdge(verteces[10], verteces[21]);
	AddEdge(verteces[12], verteces[13]);
	AddEdge(verteces[12], verteces[18]);
	AddEdge(verteces[13], verteces[14]);
	AddEdge(verteces[13], verteces[17]);
	AddEdge(verteces[14], verteces[15]);
	AddEdge(verteces[15], verteces[16]);
	AddEdge(verteces[17], verteces[18]);
	AddEdge(verteces[18], verteces[19]);
	AddEdge(verteces[18], verteces[20]);
	AddEdge(verteces[20], verteces[21]);
	AddEdge(verteces[21], verteces[22]);
	pass
	
func CreateGraph(start : Vertex):
	ResetPaths();
	
	var current : Vertex = start;
	
	current.distance = 0;
	current.permanent = true;
	
	CheckNeighbors(current);
	current = ShortestVertex();
	while(current != null):
		current.permanent = true;
		CheckNeighbors(current);
		current = ShortestVertex();
	
	
	pass
	
func CheckNeighbors(current : Vertex):
	
	var indexVertex : int = verteces.find(current);
	
	for i in adjMatrix.size():
		if(adjMatrix[indexVertex][i] > 0 && !verteces[i].permanent):
			if(adjMatrix[indexVertex][i] + current.distance < verteces[i].distance):
				verteces[i].distance = adjMatrix[indexVertex][i] + current.distance;
				verteces[i].previous = current;
				
	pass

func ShortestVertex():
	var current : Vertex = null;
	var currentDistance : float = 1000000;
	
	for i in verteces.size():
		if(verteces[i].distance < currentDistance && !verteces[i].permanent):
			current = verteces[i];
			currentDistance = current.distance;
			
	return current;
	
func ResetPaths():
	for i in verteces.size():
		verteces[i].Reset();
		
	pass
