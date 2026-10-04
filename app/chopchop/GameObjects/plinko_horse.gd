class_name PlinkoHorseScript extends RigidBody3D

var HasGameStarted = false

@export var Gravity = 1.0;
@export var BeginCameraPosition = Vector3(6, 13, 20)
@export var FallingCameraOffset = 5.0
@export var MoveAmount = 1.0

@onready var BeginCamera = $BeginCam

func _ready() -> void:
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
	
func _reset_horse() -> void:
	BeginCamera.make_current()
	HasGameStarted = false
	gravity_scale = 0.0
	angular_velocity = Vector3.ZERO
	set_linear_velocity(Vector3.ZERO)
