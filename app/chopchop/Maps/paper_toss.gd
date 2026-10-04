extends Node3D

@onready var Bin = $PlinkoCup
@onready var CurrentPosition = Bin.position
@onready var ResetCollision = $PaperTossReset
@onready var Horse: PaperTossHorse = $PaperTossHorse

@onready var PaperTossProgressBar: PaperTossProgressBarScript = $UI/Control/ProgressBar

var total_score: int = 0

var times_ran: int = 0

func _ready() -> void:
	Bin.OnScore.connect(_OnScore)
	ResetCollision.OnHit.connect(_ResetHorse)
	Horse.OnFiring.connect(_on_firing)

func _on_firing(velo: Vector2, normDir: Vector2):
	PaperTossProgressBar.on_firing(velo, normDir)

func _OnScore(_score) -> void:
	total_score += _score
	_ResetHorse()

func _ResetHorse() -> void:
	if times_ran < 4:
		await get_tree().create_timer(1.5).timeout
		Horse._reset()
		var RandomNumber = randf_range(-10.0, 10.0)
		Bin.set_position(Vector3(RandomNumber, CurrentPosition.y, CurrentPosition.z))
		times_ran += 1
	else:
		var scene = load("res://UI/paper_toss_finished_ui.tscn")
		var instance = scene.instantiate()
		instance._set_score(total_score)
		add_child(instance)
	await get_tree().create_timer(1.5).timeout
	Horse._reset()
	var RandomNumber = randf_range(-10.0, 10.0)
	Bin.set_position(Vector3(RandomNumber, CurrentPosition.y, CurrentPosition.z))
