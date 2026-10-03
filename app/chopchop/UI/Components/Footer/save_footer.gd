extends HBoxContainer

func _on_button_pressed() -> void:
	get_tree().get_first_node_in_group("HorseGroup")._save_horse()

func _on_button_2_pressed() -> void:
	get_tree().get_first_node_in_group("HorseGroup")._load_horse()
