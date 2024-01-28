extends VideoStreamPlayer



func _on_CutsceneBegin() -> void:
	play();


func endCutscene() -> void:
	get_tree().call_group("CBegin", "_on_Begin");
