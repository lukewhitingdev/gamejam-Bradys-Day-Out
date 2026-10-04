extends Node3D

var cups: Array[PlinkoCup] = []
var rods: Array[PlinkoRod] = []

@export var MultiplierIncrease: float = 0.1

@onready var horse_spawn: Marker3D = $HorseSpawn
@onready var plinko_horse: PlinkoHorseScript = $PlinkoHorse
@onready var hud_scene = load("res://UI/PlinkoHud.tscn")
@onready var hud_instance = hud_scene.instantiate()

var total_score: float = 0
var multiplier: float = 1.0
var times_ran: int = 0;
 
func _ready():
	var children = get_children()
	for child in children:
		print("child = ", child.name)
		if (child is PlinkoCup):
			cups.append(child as PlinkoCup) 
		elif child.name == "PlinkoRods":
			var childRods = child.get_children()
			print("child = ", child)
			for rod in childRods:
				if rod is PlinkoRod:
					rod.OnHit.connect(_on_plinko_rod_hit)

	_setup_events(cups)
	
	hud_instance._set_score(total_score)
	hud_instance._set_multiplier(multiplier)
	add_child(hud_instance)
	
func _setup_events(items: Array[PlinkoCup]):
	for item in items:
		item.OnScore.connect(_on_plinko_scored)

func _on_plinko_scored(score: float):
	print("Updated score to ", score, " multiplier = ", multiplier)
	total_score += (score * multiplier)
	hud_instance._set_score(total_score)
	await get_tree().create_timer(1.5).timeout
	_reset_horse() 

func _on_plinko_rod_hit():
	multiplier += MultiplierIncrease
	print("Updated multiplier to %s" % [multiplier])
	hud_instance._set_multiplier(multiplier)

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
	
