class_name PlinkoCup extends Node3D

@export var Score: int = 0

signal OnScore(score)

func _ready() -> void:
	var area3d = $StaticBody3D/Area3D
	area3d.body_entered.connect(_hit_cup)
	OnScore.connect(_Debug_Tally_Score)

func _hit_cup(body) -> void:
	if body is RigidBody3D:
		OnScore.emit(Score)

func _Debug_Tally_Score(score) -> void:
	print("Plinko end. Score = ", score)
