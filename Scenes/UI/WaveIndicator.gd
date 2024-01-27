extends Sprite2D

# Components
@onready var WaveLabel : RichTextLabel = $WaveLabel;


# Processes

func _on_WaveChanged(wave_number : int) -> void:
	WaveLabel.text = " %1d" % wave_number;
