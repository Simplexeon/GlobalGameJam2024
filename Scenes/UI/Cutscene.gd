extends VideoStreamPlayer



func _on_CutsceneBegin() -> void:
	endCutscene();


func endCutscene() -> void:
	get_tree().call_group("CBegin", "_on_Begin");
