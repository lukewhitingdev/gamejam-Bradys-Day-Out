extends Node3D

var AddedHorseAccessories: Array[HorseAccessoryData]
var AddedHorseAccessoriesNodes: Array[Node3D]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("HorseGroup")
	for AccessoryData in Horsinator4000mk7.HorseAccessories:
		_add_accessory(AccessoryData)
		
func _load_horse() -> void:
	for ChildNode in AddedHorseAccessoriesNodes:
		print(ChildNode.name)
		ChildNode.queue_free()
		
	AddedHorseAccessoriesNodes.clear()
	AddedHorseAccessories.clear()

	print("horse defucked")
		
	for AccessoryData in Horsinator4000mk7.HorseAccessories:
		_add_accessory(AccessoryData)
		
func _add_accessory(Data: HorseAccessoryData) -> void:
	AddedHorseAccessories.push_back(Data)
	var scene = load(Data.AccessoryPath)
	var instance = scene.instantiate()
	add_child(instance)
	instance.global_transform = Data.AccessoryTransform
	AddedHorseAccessoriesNodes.push_back(instance)

func _save_horse() -> void:
	Horsinator4000mk7.HorseAccessories.clear()
	Horsinator4000mk7.HorseAccessories.append_array(AddedHorseAccessories)
