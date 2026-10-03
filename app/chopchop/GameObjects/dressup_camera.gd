extends Node3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
var bMouseLook: bool = false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Right_Click"):
		bMouseLook = true
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		
	if event.is_action_released("Right_Click"):
		bMouseLook = false
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
	if event is InputEventMouseMotion && bMouseLook:
		$SpringArm3D.rotation_degrees.y -= event.relative.x * 0.3
		$SpringArm3D.rotation_degrees.x -= event.relative.y * 0.3
		$SpringArm3D.rotation_degrees.x = clamp($SpringArm3D.rotation_degrees.x, -89, 2)
