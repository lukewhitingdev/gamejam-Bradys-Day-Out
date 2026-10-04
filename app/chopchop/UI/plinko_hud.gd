extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
func _set_score(score: int) -> void:
	%ScoreText.text = "Score: " + str(score)

func _set_multiplier(multiplier: float) -> void:
	%Multiplier.text = "Multiplier: " + str(multiplier)
