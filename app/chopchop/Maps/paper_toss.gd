extends Node3D

@onready var Bin = $PlinkoCup
@onready var CurrentPosition = Bin.position
@onready var ResetCollision = $PaperTossReset

func _ready() -> void:
	Bin.OnScore.connect(_OnScore)
	ResetCollision.OnHit.connect(_ResetHorse)

func _OnScore(_score) -> void:
	_ResetHorse()

func _ResetHorse() -> void:
	var Horse = $PaperTossHorse
	await get_tree().create_timer(1.5).timeout
	Horse._reset()
	var RandomNumber = randf_range(-10.0, 10.0)
	Bin.set_position(Vector3(RandomNumber, CurrentPosition.y, CurrentPosition.z))
