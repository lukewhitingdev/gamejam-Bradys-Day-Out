extends Node3D

@onready var camera: Camera3D = $Camera3D
@onready var tweenNodeParent = $Camera_Tween_Nodes
@onready var vineBoomPlayer: AudioStreamPlayer = $VineBoomPlayer
@onready var celebrationPlayer: AudioStreamPlayer = $CelebrationPlayer
@onready var ScoreText = $UI/Control/VBoxContainer/RichTextLabel
@onready var celebrationUI: Control = $UI/Control

@export var lookAtTarget: Node3D
@export var transitionLerp: float = 1

var tweenData: Array[TweenMarkerScript] = []
var tweenPositons: Array[Vector3] = []

var hasFinishedCameraTransition = false

var currentTweenIndex = 0

signal OnCameraTransiton
signal OnCameraTransitionsFinish 

func _ready():
	var tweenNodes = tweenNodeParent.get_children()
	for node in tweenNodes:
		var data: TweenMarkerScript = node as TweenMarkerScript;
		print("Added data: %s" % data)
		tweenData.append(data)
		tweenPositons.append(node.position)

	OnCameraTransiton.connect(_on_camera_transition)
	OnCameraTransitionsFinish.connect(_on_camera_transition_finish)
	
	ScoreText.text = str("Score = ", GlobalScore.TotalScore)
	
func _on_camera_transition():
	vineBoomPlayer.play()
	pass

func _on_camera_transition_finish():
	_trigger_horray()

func _trigger_horray():
	vineBoomPlayer.stop()
	celebrationPlayer.play()
	celebrationUI.show()	
	pass

func _on_timer_timeout() -> void:
	if (hasFinishedCameraTransition):
		return

	if(tweenData.size() <= 0):
		return

	print("Tweening pos: %s" % [currentTweenIndex])

	if(currentTweenIndex >= tweenData.size()):
		return

	var data = tweenData[currentTweenIndex]
	var pos = tweenPositons[currentTweenIndex]

	print("Tweening to data: %s" % data)

	var tween = get_tree().create_tween().bind_node(camera)
	tween.set_ease(data.tweenType)

	tween.tween_property(camera, "position", pos, data.positionTweenSpeed)
	tween.tween_property(camera, "fov", data.cameraFov, data.fovTweenSpeed)

	currentTweenIndex += 1

	OnCameraTransiton.emit()

	hasFinishedCameraTransition = data.isFinalMarker

	if(data.isFinalMarker):
		OnCameraTransitionsFinish.emit()

func _process(_delta: float) -> void:
	camera.look_at(lookAtTarget.position)
