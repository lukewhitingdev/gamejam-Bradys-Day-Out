extends Node3D

@onready var Bin = $PlinkoCup
@onready var CurrentPosition = Bin.position

func _ready() -> void:
	Bin.OnScore.connect(_OnScore)

func _OnScore(_score) -> void:
	var Horse = $PaperTossHorse
	await get_tree().create_timer(2.0).timeout
	Horse._reset()
	var RandomNumber = randf_range(-10.0, 10.0)
	Bin.set_position(Vector3(RandomNumber, CurrentPosition.y, CurrentPosition.z))
