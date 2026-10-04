extends Node

var TotalScore: int = 0.0

func _add_score(score: int) -> void:
	TotalScore += score
	print("CurrentScore = ", TotalScore)
