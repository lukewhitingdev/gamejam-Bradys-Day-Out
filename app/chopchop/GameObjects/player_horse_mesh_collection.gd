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
		
	for AccessoryData in Horsinator4000mk7.HorseAccessories:
		_add_accessory(AccessoryData)
		
func _remove_last_accessory() -> void:
	if !AddedHorseAccessoriesNodes.is_empty():
		AddedHorseAccessoriesNodes.back().queue_free()
		AddedHorseAccessoriesNodes.pop_back()
		AddedHorseAccessories.pop_back()
		
func _can_add_accessory() -> bool:
	return AddedHorseAccessories.size() < Horsinator4000mk7.MaxAccessoriesCount

func _add_accessory(Data: HorseAccessoryData) -> void:
	if _can_add_accessory():
		var scene = Data.AccessoryResource
		var instance = scene.instantiate()
		add_child(instance)
		instance.add_to_group("Accessories")
		if !Data.bUseLocalTransform:
			instance.global_transform = Data.AccessoryTransform
			Data.AccessoryTransform = instance.transform
			Data.bUseLocalTransform = true
		else:
			instance.transform = Data.AccessoryTransform
			
		AddedHorseAccessories.push_back(Data)
		AddedHorseAccessoriesNodes.push_back(instance)

func _save_horse() -> void:
	Horsinator4000mk7.HorseAccessories.clear()
	Horsinator4000mk7.HorseAccessories.append_array(AddedHorseAccessories)
