extends Node

var TotalScore: float = 0.0

func _add_score(score: float) -> void:
	TotalScore += score
	print("CurrentScore = ", TotalScore)
