class_name PaperTossHorse extends RigidBody3D

var ShouldFire = false
var CanFire = true
var OriginalPosition = Vector3.ZERO
var OriginalRotation = Vector3.ZERO
@onready var ThrowSound = $AudioStreamPlayer

@export var Gravity = 1.0;
@export var BeginCameraPosition = Vector3(6, 13, 20)
@export var FallingCameraOffset = 5.0
@export var MoveAmount = 1.0

signal OnFiring(velo: Vector2, normDir: Vector2)

func _ready() -> void:
	var BeginCamera = $BeginCam
	BeginCamera.position = BeginCameraPosition
	BeginCamera.make_current()
	OriginalPosition = position
	OriginalRotation = rotation
	gravity_scale = 0.0

func _input(event: InputEvent) -> void:
	if CanFire:
		if event is InputEventMouse:
			

			if event.is_action_released("Left_Click"):
				ShouldFire = true
			elif event is InputEventMouseMotion:
				var Velocity = event.velocity
				var length = Velocity.length() * 0.01
				var Direction = Velocity.normalized()

				OnFiring.emit(Velocity, Direction)

				if(ShouldFire):
					ShouldFire = false
					CanFire = false
					gravity_scale = 1.0
					var Impulse = Vector3(Direction.x, -Direction.y, -1) * length;
					apply_impulse(Impulse)
					ThrowSound.play()

	if event.is_action_pressed("start_game"):
		_reset()

func _reset():
	CanFire = true
	gravity_scale = 0.0
	angular_velocity = Vector3.ZERO
	set_linear_velocity(Vector3.ZERO)
	set_global_position(OriginalPosition)
	set_global_rotation(OriginalRotation)
	
