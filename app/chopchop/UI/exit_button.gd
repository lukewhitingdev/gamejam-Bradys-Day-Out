extends Button



func _on_gui_input(event: InputEvent) -> void:
	if (event.is_action_pressed("Left_Click")):
		get_tree().quit()	
