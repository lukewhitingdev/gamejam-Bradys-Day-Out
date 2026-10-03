extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Maps/DressupMap.tscn")

func _on_exit_button_pressed() -> void:
	pass # Replace with function body.
