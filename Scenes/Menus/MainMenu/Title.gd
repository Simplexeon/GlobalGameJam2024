@tool
extends TextureRect

# Export Vars
@export var CenterHeightOffset : int;

# Processes

func _process(delta: float) -> void:
	if(Engine.is_editor_hint() == false):
		return;
	anchors_preset = PRESET_CENTER;
	anchor_bottom = 0.5;
	anchor_top = 0.5;
	anchor_left = 0.5;
	anchor_right = 0.5;
	position.y -= CenterHeightOffset;
