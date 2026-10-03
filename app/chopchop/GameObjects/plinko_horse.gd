extends RigidBody3D

var HasGameStarted = false

@export var Gravity = 1.0;
@export var BeginCameraPosition = Vector3(6, 13, 20)
@export var FallingCameraOffset = 5.0
@export var MoveAmount = 1.0

func _ready() -> void:
	var BeginCamera = $BeginCam
	BeginCamera.position = BeginCameraPosition
	BeginCamera.make_current()
	gravity_scale = 0
	print("Player Ready")
	
func _unhandled_input(event: InputEvent) -> void:
	if !HasGameStarted:
		if event is InputEventKey:
			if event.is_action_pressed("start_game"):
				var FallCam = $FallingCam
				gravity_scale = Gravity
				print("key pressed")
				HasGameStarted = true
				FallCam.make_current()
			elif event.is_action_pressed("move_left"):
				position = position + Vector3(-MoveAmount, 0.0, 0.0) 
			elif event.is_action_pressed("move_right"):
				position = position + Vector3(MoveAmount, 0.0, 0.0) 

func _process(_delta: float) -> void:
	var FallCam = $FallingCam
	FallCam.position = Vector3(position.x, position.y, position.z + FallingCameraOffset)
