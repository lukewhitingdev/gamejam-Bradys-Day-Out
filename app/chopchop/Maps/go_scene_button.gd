extends Button

@onready var ClickAudioStreamPlayer: AudioStreamPlayer = $AudioStreamPlayer
@export var targetScene: PackedScene

func _on_gui_input(event: InputEvent) -> void:
	if(event.is_action_pressed("Left_Click")):
		ClickAudioStreamPlayer.play()
		get_tree().change_scene_to_packed(targetScene)
