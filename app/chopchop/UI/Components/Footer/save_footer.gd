class_name SaveFooterScript extends HBoxContainer

signal OnFoldChanged(bool)

@onready var Horse: Node3D = get_tree().get_first_node_in_group("HorseGroup")

func _on_button_pressed() -> void:
	Horse._save_horse()
	get_tree().change_scene_to_file("res://Maps/Plinko.tscn")

func _on_button_2_pressed() -> void:
	Horse._remove_last_accessory()
	
func _process(_delta: float) -> void:
	%AccessoriesCount.text = "Accessories: " + str(Horse.AddedHorseAccessories.size()) + " / " + str(Horsinator4000mk7.MaxAccessoriesCount)

func _on_foldable_container_folding_changed(is_folded: bool) -> void:
	OnFoldChanged.emit(is_folded)
