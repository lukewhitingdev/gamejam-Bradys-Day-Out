extends Node3D

@export var HitSpeedRange: Vector2 = Vector2(3.0, 10.0)

@onready var area3d = $StaticBody3D/Area3D
@onready var OriginalPos: Vector3 = area3d.global_position

signal OnHit()

func _ready() -> void:
	area3d.body_entered.connect(_hit_cup)
	OnHit.connect(_Debug_Tally_Score)

func _hit_cup(body) -> void:
	if body is RigidBody3D:
		OnHit.emit()
		var Direction = (body.position - OriginalPos).normalized()
		Direction.z = 0.0
		var HitSpeed = randf_range(HitSpeedRange.x, HitSpeedRange.y)
		body.apply_impulse(Direction * HitSpeed)

func _Debug_Tally_Score() -> void:
	print("Bounce")
