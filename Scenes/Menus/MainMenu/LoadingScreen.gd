@tool
extends Control

# Object Vars
var loading = false;


# Processes

func _ready() -> void:
	var visible = false;
	var viewport_rect : Vector2 = Vector2(ProjectSettings.get_setting("display/window/size/viewport_width"), ProjectSettings.get_setting("display/window/size/viewport_height"));
	size = viewport_rect;

func _on_LoadGame() -> void:
	visible = true;
	loading = true;

func _physics_process(delta: float) -> void:
	if(!loading):
		return;
	if(ResourceLoader.load_threaded_get_status(Globals.game_file) == ResourceLoader.THREAD_LOAD_LOADED):
		get_tree().change_scene_to_packed(ResourceLoader.load_threaded_get(Globals.game_file));
