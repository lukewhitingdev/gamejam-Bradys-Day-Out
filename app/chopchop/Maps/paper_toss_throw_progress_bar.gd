class_name PaperTossProgressBarScript extends ProgressBar 

@export var maxVelo = 5000

func on_firing(velo: Vector2, normDir: Vector2):
	var powerPerc = remap(min(velo.length(), maxVelo), 0, maxVelo, 0, 100)
	self.value = powerPerc
