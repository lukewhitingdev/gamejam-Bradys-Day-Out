extends Node3D

var bMouseLook: bool = false
var TargetRotation: Vector3 = Vector3()
var bValidPlacingPosition: bool = false;

@onready var AssetSelector: TableAssetSelectorScript = $"../UI/ColorRect/VBoxContainer/TabAssetSelector"

var hasCurrentSelectedAsset = false
var currentSelectedAsset: Resource

const DegToRad = 0.0174533

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	TargetRotation = %SpringArm3D.rotation
	%SpringArm3D.rotation_degrees = Vector3(-89, 0, -60)

	_setup_asset_selector_events(_on_asset_changed)

func _setup_asset_selector_events(OnSelected: Callable):
	var script = AssetSelector as TableAssetSelectorScript
	script.OnAssetSelected.connect(OnSelected)

func _on_asset_changed(data: GridItemData):
	print_debug("Changed asset to: %s with data: %s" % [data.Name, data.Asset])
	currentSelectedAsset = data.Asset
	hasCurrentSelectedAsset = true
	var node = data.Asset.instantiate()
	var children = %cursorobj.get_children()

	for child in children:
		child.queue_free()

	%cursorobj.add_child(node) 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var CurrentRotQuat: Quaternion = Quaternion.from_euler(%SpringArm3D.rotation)
	var TargetRotQuat: Quaternion = Quaternion.from_euler(TargetRotation)
	%SpringArm3D.rotation = CurrentRotQuat.slerp(TargetRotQuat, (1 - delta) * 0.075).get_euler()
	%SpringArm3D.rotation.z = 0.0
	
	if(!bMouseLook):
		var MouseTraceStart: Vector3 = %Camera3D.project_ray_origin(get_viewport().get_mouse_position())
		var MouseNormal: Vector3 = %Camera3D.project_ray_normal(get_viewport().get_mouse_position())
		var MouseTraceEnd: Vector3 = MouseNormal * 100 + %Camera3D.global_position
		
		var params: PhysicsRayQueryParameters3D = PhysicsRayQueryParameters3D.new();
		params.to = MouseTraceEnd 
		params.from = MouseTraceStart 

		var result = get_world_3d().direct_space_state.intersect_ray(params)
		
		bValidPlacingPosition = !(result as Dictionary).is_empty()
		
		if bValidPlacingPosition:
			%cursorobj.look_at_from_position(Vector3(), result.normal)
			%cursorobj.rotation_degrees.x -= 90
			%cursorobj.global_position = result.position
		else:
			%cursorobj.rotation_degrees = Vector3(0, 0, 0)
			%cursorobj.global_position = MouseNormal * 3 + %Camera3D.global_position
			
	%cursorobj.visible = !bMouseLook

	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Right_Click"):
		bMouseLook = true
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		
	if event.is_action_released("Right_Click"):
		bMouseLook = false
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
	if event is InputEventMouseMotion && bMouseLook:
		TargetRotation.y -= event.relative.x * 0.3 * DegToRad
		TargetRotation.x -= event.relative.y * 0.3 * DegToRad
		TargetRotation.x = clamp(TargetRotation.x, -89 * DegToRad, 2 * DegToRad)
		
	if event.is_action_pressed("Left_Click") && bValidPlacingPosition && hasCurrentSelectedAsset:
		var scene = currentSelectedAsset
		var instance = scene.instantiate()
		%Horse.add_child(instance)
		var params: HorseAccessoryData = HorseAccessoryData.new()
		params.AccessoryPath = "res://Models/horse.tscn"
		params.AccessoryTransform = %cursorobj.global_transform
		%Horse._add_accessory(params)
		
