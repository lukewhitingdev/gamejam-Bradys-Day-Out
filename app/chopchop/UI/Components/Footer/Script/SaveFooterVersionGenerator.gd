extends RichTextLabel


@onready var ClickStreamPlayer: AudioStreamPlayer = $"../ClickStreamPlayer"
@onready var rng

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rng = RandomNumberGenerator.new()

	_generate_version()

func _on_gui_input(event: InputEvent) -> void:
	if(event.is_action_pressed("Left_Click")):
		_generate_version()

func _generate_version():
	ClickStreamPlayer.play()
	var major = rng.randi_range(0, 24)
	var minor = rng.randi_range(0, 36)
	var bugfix = rng.randi_range(0, 68)
	var rc = rng.randi_range(0, 5)
	var richTextLabel: RichTextLabel = self

	richTextLabel.text = "Horse Visualizer v%d.%d.%drc%d" % [major, minor, bugfix, rc]
