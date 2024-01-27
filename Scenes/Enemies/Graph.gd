extends Node3D

class_name Graph

var verteces : Array : 
	set(value):
		pass;
	get: 
		return verteces;
		pass;

var adjMatrix : Array[Array];

# Called when the node enters the scene tree for the first time.
func _ready():
	verteces = get_children();
	adjMatrix = [];
	for i in verteces.size():
		adjMatrix[i] = [];
		for j in verteces.size():
			adjMatrix[i][j] = 0;
			
	
	Connect();
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func AddEdge(vert1 : Vertex, vert2 : Vertex):
	#populate adjacency matrix
	pass

func Connect():
	# manually connect verteces
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
