extends Node3D

var my_body_array = []
@export var Score = 0

signal OnScore(score)

func _ready() -> void:
	print("Plinko start")
	var area3d = $StaticBody3D/Area3D
	my_body_array.append_array([$StaticBody3D,$StaticBody3D2,$StaticBody3D3,$StaticBody3D4,$StaticBody3D5])
	area3d.body_entered.connect(_hit_cup)
	OnScore.connect(_Debug_Tally_Score)

func _hit_cup(body) -> void:
	if (!my_body_array.has(body)):
		OnScore.emit(Score)

func _Debug_Tally_Score(score) -> void:
	print("Plinko end. Score = ", score)
