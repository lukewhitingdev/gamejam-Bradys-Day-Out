extends Control

@onready var ClickSoundPlayer: AudioStreamPlayer = $AudioStreamPlayer

func _on_button_pressed() -> void:
	ClickSoundPlayer.play()
	queue_free()
