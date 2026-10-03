extends Node3D

var bMouseLook: bool = false
var TargetRotation: Vector3 = Vector3()

const DegToRad = 0.0174533

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	TargetRotation = $SpringArm3D.rotation
	$SpringArm3D.rotation_degrees = Vector3(-89, 0, -60)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var CurrentRotQuat: Quaternion = Quaternion.from_euler($SpringArm3D.rotation)
	var TargetRotQuat: Quaternion = Quaternion.from_euler(TargetRotation)
	$SpringArm3D.rotation = CurrentRotQuat.slerp(TargetRotQuat, (1 - delta) * 0.075).get_euler()
	$SpringArm3D.rotation.z = 0.0

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
