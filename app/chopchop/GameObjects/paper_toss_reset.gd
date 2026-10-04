extends Node3D

signal OnHit()

func _ready() -> void:
	print("Plinko start")
	var area3d = $StaticBody3D/Area3D
	area3d.body_entered.connect(_hit_cup)
	OnHit.connect(_Debug_Tally_Score)

func _hit_cup(body) -> void:
	if body is RigidBody3D:
		OnHit.emit()

func _Debug_Tally_Score() -> void:
	print("Paper toss failed")
