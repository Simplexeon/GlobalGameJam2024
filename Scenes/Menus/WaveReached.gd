extends RichTextLabel


# Processes

func _ready() -> void:
	text = "[center]%d[/center]" % Globals.wave_reached;
	bbcode_enabled = true;
	ResourceLoader.load_threaded_request(Globals.game_file);
