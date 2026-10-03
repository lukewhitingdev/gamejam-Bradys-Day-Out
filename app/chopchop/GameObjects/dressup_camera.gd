extends Node3D

var bMouseLook: bool = false
var TargetRotation: Vector3 = Vector3()

@onready var AssetSelector: TableAssetSelectorScript = $"../UI/VBoxContainer/TabAssetSelector"

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
	var cursor:MeshInstance3D = %cursorobj as MeshInstance3D
	cursor.mesh = data.Asset

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var CurrentRotQuat: Quaternion = Quaternion.from_euler(%SpringArm3D.rotation)
	var TargetRotQuat: Quaternion = Quaternion.from_euler(TargetRotation)
	%SpringArm3D.rotation = CurrentRotQuat.slerp(TargetRotQuat, (1 - delta) * 0.075).get_euler()
	%SpringArm3D.rotation.z = 0.0
	
	var MouseTraceStart: Vector3 = %Camera3D.project_ray_origin(get_viewport().get_mouse_position())
	var MouseTraceEnd: Vector3 = %Camera3D.project_ray_normal(get_viewport().get_mouse_position()) * 100 + %Camera3D.position
	
	#%cursorobj.global_position = MouseTraceEnd
	
	var params: PhysicsRayQueryParameters3D = PhysicsRayQueryParameters3D.new();
	params.to = MouseTraceEnd 
	params.from = MouseTraceStart 

	var result = get_world_3d().direct_space_state.intersect_ray(params)
	
	if result:
		#%cursorobj.rotation = result.normal
		%cursorobj.look_at_from_position(Vector3(), result.normal)
		%cursorobj.rotation_degrees.x -= 90
		%cursorobj.global_position = result.position

	
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
		
