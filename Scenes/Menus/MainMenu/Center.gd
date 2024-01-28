@tool
extends Control


# Processes

func _ready() -> void:
	var viewport_rect : Vector2 = Vector2(ProjectSettings.get_setting("display/window/size/viewport_width"), ProjectSettings.get_setting("display/window/size/viewport_height"));
	size = viewport_rect;
	anchor_bottom = 0.5;
	anchor_top = 0.5;
	anchor_left = 0.5;
	anchor_right = 0.5;
	position = Vector2.ZERO;
