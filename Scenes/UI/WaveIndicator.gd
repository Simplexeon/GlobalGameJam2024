extends Sprite2D

# Object vars
var time : float = 0.0;
var wave : int = 0;

# Components
@onready var WaveLabel : RichTextLabel = $WaveLabel;
@onready var TimeLabel : RichTextLabel = $TimeLabel;


# Processes

func _physics_process(delta: float) -> void:
	time += delta;
	var minutes : int = int(time) / 60;
	var seconds : int = int(time) - (60 * minutes);
	TimeLabel.text = "[center]%02d:%02d[/center]" % [minutes, seconds];
	TimeLabel.bbcode_enabled = true;

func _on_WaveChanged(wave_number : int) -> void:
	wave = wave_number;
	WaveLabel.text = " %1d" % wave_number;

func _on_PlayerGrabbed() -> void:
	Globals.wave_reached = wave;
