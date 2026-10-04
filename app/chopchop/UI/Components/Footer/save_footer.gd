class_name SaveFooterScript extends HBoxContainer


@onready var ClickStreamPlayer: AudioStreamPlayer = $ClickStreamPlayer
@export var nextScene: PackedScene 

signal OnFoldChanged(bool)

@onready var Horse: Node3D = get_tree().get_first_node_in_group("HorseGroup")

func _on_button_pressed() -> void:
	ClickStreamPlayer.play()
	Horse._save_horse()
	get_tree().change_scene_to_packed(nextScene)

func _on_button_2_pressed() -> void:
	ClickStreamPlayer.play()
	Horse._remove_last_accessory()
	
func _process(_delta: float) -> void:
	%AccessoriesCount.text = "Accessories: " + str(Horse.AddedHorseAccessories.size()) + " / " + str(Horsinator4000mk7.MaxAccessoriesCount)

func _on_foldable_container_folding_changed(is_folded: bool) -> void:
	ClickStreamPlayer.play()
	OnFoldChanged.emit(is_folded)
