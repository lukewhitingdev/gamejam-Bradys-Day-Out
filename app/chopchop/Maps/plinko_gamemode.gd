extends Node3D

var cups: Array[PlinkoCup] = []

@onready var horse_spawn: Marker3D = $HorseSpawn
@onready var plinko_horse: PlinkoHorseScript = $PlinkoHorse

var total_score: int = 0
 
func _ready():
	var children = get_children()
	for child in children:
		if (child is PlinkoCup):
			cups.append(child as PlinkoCup) 

	_setup_events(cups)

func _setup_events(items: Array[PlinkoCup]):
	for item in items:
		item.OnScore.connect(_on_plinko_scored)

func _on_plinko_scored(score: int):
	print("Updated score to %s" % [score])
	total_score += score
	await get_tree().create_timer(1.5).timeout
	_reset_horse()

func _reset_horse():
	print("reseting horse")
	plinko_horse._reset_horse()
	plinko_horse.set_global_position(horse_spawn.position)
	plinko_horse.set_global_rotation(horse_spawn.rotation)
