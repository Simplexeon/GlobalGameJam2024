extends Node3D

class_name Graph

var verteces : Array : 
	set(value):
		verteces = value;
	get: 
		return verteces;

var adjMatrix : Array[Array];

# Called when the node enters the scene tree for the first time.
func _ready():
	call_deferred("deferred_ready");

func deferred_ready() -> void:
	verteces = get_children();
	adjMatrix = [];
	for i in verteces.size():
		adjMatrix.append([]);
		for j in verteces.size():
			adjMatrix[i].append(0);
			
	
	Connect();


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
	
	AddEdge(verteces[0], verteces[51]);
	AddEdge(verteces[0], verteces[3]);
	AddEdge(verteces[1], verteces[2]);
	AddEdge(verteces[2], verteces[3]);
	AddEdge(verteces[2], verteces[42]);
	AddEdge(verteces[3], verteces[4]);
	AddEdge(verteces[4], verteces[8]);
	AddEdge(verteces[5], verteces[6]);
	AddEdge(verteces[6], verteces[7]);
	AddEdge(verteces[6], verteces[8]);
	AddEdge(verteces[6], verteces[9]);
	AddEdge(verteces[7], verteces[8]);
	AddEdge(verteces[7], verteces[9]);
	AddEdge(verteces[7], verteces[10]);
	AddEdge(verteces[8], verteces[40]);
	AddEdge(verteces[9], verteces[10]);
	AddEdge(verteces[9], verteces[11]);
	AddEdge(verteces[9], verteces[17]);
	AddEdge(verteces[10], verteces[11]);
	AddEdge(verteces[10], verteces[15]);
	AddEdge(verteces[11], verteces[12]);
	AddEdge(verteces[12], verteces[13]);
	AddEdge(verteces[12], verteces[14]);
	#AddEdge(verteces[13], verteces[14]);
	AddEdge(verteces[13], verteces[15]);
	AddEdge(verteces[14], verteces[16]);
	AddEdge(verteces[14], verteces[18]);
	AddEdge(verteces[14], verteces[17]);
	AddEdge(verteces[15], verteces[16]);
	AddEdge(verteces[16], verteces[17]);
	AddEdge(verteces[16], verteces[18]);
	AddEdge(verteces[17], verteces[26]);
	AddEdge(verteces[17], verteces[28]);
	AddEdge(verteces[18], verteces[19]);
	AddEdge(verteces[18], verteces[21]);
	AddEdge(verteces[19], verteces[20]);
	AddEdge(verteces[19], verteces[49]);
	#AddEdge(verteces[20], verteces[21]);
	AddEdge(verteces[21], verteces[22]);
	AddEdge(verteces[22], verteces[23]);
	AddEdge(verteces[22], verteces[25]);
	AddEdge(verteces[23], verteces[24]);
	AddEdge(verteces[24], verteces[25]);
	AddEdge(verteces[24], verteces[26]);
	AddEdge(verteces[24], verteces[30]);
	AddEdge(verteces[25], verteces[26]);
	AddEdge(verteces[25], verteces[27]);
	AddEdge(verteces[26], verteces[27]);
	AddEdge(verteces[27], verteces[28]);
	AddEdge(verteces[28], verteces[29]);
	AddEdge(verteces[29], verteces[30]);
	AddEdge(verteces[29], verteces[41]);
	AddEdge(verteces[30], verteces[31]);
	AddEdge(verteces[30], verteces[36]);
	AddEdge(verteces[31], verteces[32]);
	AddEdge(verteces[31], verteces[33]);
	AddEdge(verteces[33], verteces[34]);
	AddEdge(verteces[34], verteces[35]);
	AddEdge(verteces[35], verteces[36]);
	AddEdge(verteces[35], verteces[37]);
	AddEdge(verteces[35], verteces[38]);
	AddEdge(verteces[35], verteces[46]);
	AddEdge(verteces[36], verteces[37]);
	AddEdge(verteces[37], verteces[38]);
	AddEdge(verteces[38], verteces[39]);
	AddEdge(verteces[38], verteces[44]);
	AddEdge(verteces[39], verteces[40]);
	AddEdge(verteces[39], verteces[44]);
	AddEdge(verteces[40], verteces[42]);
	AddEdge(verteces[40], verteces[41]);
	AddEdge(verteces[4], verteces[41]);
	AddEdge(verteces[42], verteces[43]);
	AddEdge(verteces[43], verteces[44]);
	AddEdge(verteces[44], verteces[45]);
	AddEdge(verteces[45], verteces[46]);
	AddEdge(verteces[45], verteces[47]);
	AddEdge(verteces[46], verteces[48]);
	AddEdge(verteces[47], verteces[48]);
	AddEdge(verteces[49], verteces[20]);
	AddEdge(verteces[49], verteces[22]);
	AddEdge(verteces[2], verteces[50]);
	AddEdge(verteces[20], verteces[52]);
	AddEdge(verteces[13], verteces[53]);
	AddEdge(verteces[1], verteces[54]);
	AddEdge(verteces[48], verteces[55]);
	AddEdge(verteces[50], verteces[51]);
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
	



func CheckNeighbors(current : Vertex):
	
	var indexVertex : int = verteces.find(current);
	
	for i in adjMatrix.size():
		if(adjMatrix[indexVertex][i] > 0 && !verteces[i].permanent):
			if(adjMatrix[indexVertex][i] + current.distance < verteces[i].distance):
				verteces[i].distance = adjMatrix[indexVertex][i] + current.distance;
				verteces[i].previousVertex = current;
				
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

