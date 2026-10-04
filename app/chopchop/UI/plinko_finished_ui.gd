extends Control

@onready var onClickAudioStreamPlayer: AudioStreamPlayer = $AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
func _set_score(score: int) -> void:
	%RichTextLabel.text = "[tornado]Score: " + str(score)

func _on_button_pressed() -> void:
	onClickAudioStreamPlayer.play()
	get_tree().change_scene_to_file("res://Maps/PaperToss.tscn")
