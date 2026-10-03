extends RigidBody3D

var HasGameStarted = false

@export var Gravity = 0.0;

func _ready() -> void:
	var Camera = $Camera3D
	Camera.rotation = Vector3(0, 0.0, 0.0)
	gravity_scale = 0
	print("Player Ready")
	
func _unhandled_input(event: InputEvent) -> void:
	if !HasGameStarted:
		if event is InputEventKey:
			if event.is_action_pressed("start_game"):
				gravity_scale = Gravity
				print("key pressed")
				HasGameStarted = true
			elif event.is_action_pressed("move_left"):
				position = position + Vector3(-1.0, 0.0, 0.0) 
			elif event.is_action_pressed("move_right"):
				position = position + Vector3(1.0, 0.0, 0.0) 

func _process(_delta: float) -> void:
	var Camera = $Camera3D
	Camera.position = Vector3(position.x, position.y, position.z + 5)
