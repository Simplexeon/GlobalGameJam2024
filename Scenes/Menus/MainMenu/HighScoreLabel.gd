extends RichTextLabel




# Processes

func _ready() -> void:
	GlobalParameters.load_data();
	if(GlobalParameters.max_score > 0):
		text = "[center]Highscore:\n%05.2f[/center]" % GlobalParameters.max_score;
		bbcode_enabled = true;
	else:
		visible = false;
