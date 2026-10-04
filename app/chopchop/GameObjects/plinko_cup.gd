class_name PlinkoCup extends Node3D

@export var RodMaterial: StandardMaterial3D
@export var Score: int = 0

signal OnScore(score)

func _ready() -> void:
	OnScore.connect(_Debug_Tally_Score)
	
	for StaticBody in get_children():
		if StaticBody is StaticBody3D:
			var StaticBodyChild = StaticBody.get_child(0)
			if StaticBodyChild and StaticBodyChild is CollisionShape3D:
				var Mesh = StaticBodyChild.get_child(0)
				if Mesh and Mesh is MeshInstance3D:
					Mesh.set_surface_override_material(0, RodMaterial)
			elif StaticBodyChild and StaticBodyChild is Area3D:
				StaticBodyChild.body_entered.connect(_hit_cup)

func _hit_cup(body) -> void:
	if body is RigidBody3D:
		OnScore.emit(Score)

func _Debug_Tally_Score(score) -> void:
	print("Plinko end. Score = ", score)
