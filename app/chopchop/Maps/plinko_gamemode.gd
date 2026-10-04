extends Node3D

var cups: Array[PlinkoCup] = []

@onready var horse_spawn: Marker3D = $HorseSpawn
@onready var plinko_horse: PlinkoHorseScript = $PlinkoHorse
@onready var scene = load("res://UI/PlinkoHud.tscn")
@onready var hud_instance = scene.instantiate()

var total_score: int = 0

var times_ran: int = 0;
 
func _ready():
	var children = get_children()
	for child in children:
		if (child is PlinkoCup):
			cups.append(child as PlinkoCup) 

	_setup_events(cups)
	
	hud_instance._set_score(total_score)
	add_child(hud_instance)
	
func _setup_events(items: Array[PlinkoCup]):
	for item in items:
		item.OnScore.connect(_on_plinko_scored)

func _on_plinko_scored(score: int):
	print("Updated score to %s" % [score])
	total_score += score
	hud_instance._set_score(total_score)
	await get_tree().create_timer(1.5).timeout
	_reset_horse() 

func _reset_horse():
	
	if times_ran < 0:
		print("reseting horse")
		plinko_horse._reset_horse()
		plinko_horse.set_global_position(horse_spawn.position)
		plinko_horse.set_global_rotation(horse_spawn.rotation)
		times_ran += 1
	else:
		var scene = load("res://UI/plinko_finished_ui.tscn")
		var instance = scene.instantiate()
		instance._set_score(total_score)
		add_child(instance)
	
