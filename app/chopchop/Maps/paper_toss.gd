extends Node3D

@onready var Bin = $PlinkoCup
@onready var CurrentPosition = Bin.position
@onready var ResetCollision = $PaperTossReset
@onready var Horse: PaperTossHorse = $PaperTossHorse

@onready var PaperTossProgressBar: PaperTossProgressBarScript = $UI/Control/ProgressBar
@onready var MultiplierText: RichTextLabel = $UI/Control/HBoxContainer/RichTextLabel

@onready var UIParent: Control = $UI/Control

var lastShotWasIn = false

var total_score: int = 0
var times_ran: int = 0

var currentMulti = 1 

signal OnMultiplier(multi: int)

func _ready() -> void:
	Bin.OnScore.connect(_OnScore)
	ResetCollision.OnHit.connect(_reset_collision)
	Horse.OnFiring.connect(_on_firing)
	OnMultiplier.connect(_on_multiplier)

	# Debug
	# OnMultiplier.emit(currentMulti)

func _on_multiplier(multi: int):
	print("OnMulti: %d" % multi)
	_update_multiplier_ui(multi)

func _update_multiplier_ui(multi: int):
	if(multi > 1 && multi <= 2):
		MultiplierText.visible = true
		MultiplierText.text = "%sx Multiplier" % [str(multi)]
		return

	if(multi > 2):
		MultiplierText.text = "[rainbow] %sx [/rainbow]  [wave] Multiplier [/wave]" % [str(multi)]
		return

	MultiplierText.visible = false

func _on_firing(velo: Vector2, normDir: Vector2):
	PaperTossProgressBar.on_firing(velo, normDir)

func _reset_collision():
	lastShotWasIn = false
	_ResetHorse()

func _OnScore(_score) -> void:
	if (lastShotWasIn == true):
		currentMulti += 1
		OnMultiplier.emit(currentMulti)

	lastShotWasIn = true
	total_score += _score * currentMulti
	GlobalScore._add_score(_score)
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
		UIParent.add_child(instance)
