extends HBoxContainer

func _on_button_pressed() -> void:
	get_tree().get_first_node_in_group("HorseGroup")._save_horse()
	get_tree().change_scene_to_file("res://Maps/Plinko.tscn")

func _on_button_2_pressed() -> void:
	get_tree().get_first_node_in_group("HorseGroup")._remove_last_accessory()
