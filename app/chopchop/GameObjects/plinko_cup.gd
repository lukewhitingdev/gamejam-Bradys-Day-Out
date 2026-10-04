class_name PlinkoCup extends Node3D

@export var RodMaterial: StandardMaterial3D
@export var Score: int = 0

signal OnScore(score)

func _ready() -> void:
	var area3d = $StaticBody3D/Area3D
	area3d.body_entered.connect(_hit_cup)
	OnScore.connect(_Debug_Tally_Score)
	var Meshes = [$StaticBody3D4/CollisionShape3D/MeshInstance3D,$StaticBody3D5/CollisionShape3D/MeshInstance3D,$StaticBody3D3/CollisionShape3D/MeshInstance3D,$StaticBody3D/Area3D/CollisionShape3D/MeshInstance3D]
	#if Meshes.size() > 0:
		#for Mesh in Meshes:
			#Mesh.set_surface_override_material(0, RodMaterial)

func _hit_cup(body) -> void:
	if body is RigidBody3D:
		OnScore.emit(Score)

func _Debug_Tally_Score(score) -> void:
	print("Plinko end. Score = ", score)
