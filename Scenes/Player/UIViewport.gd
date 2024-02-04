extends Sprite3D

# Component Vars
@onready var HUD : SubViewport = $HUD;

# Processes

func _ready() -> void:
	texture = HUD.get_texture();
