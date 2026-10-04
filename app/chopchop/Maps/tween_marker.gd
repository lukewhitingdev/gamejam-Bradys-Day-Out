class_name TweenMarkerScript extends Marker3D

@export var cameraFov:float = 90

@export var positionTweenSpeed: float = 1.0
@export var fovTweenSpeed: float = 1.0

@export var tweenType: Tween.EaseType 

@export var isFinalMarker: bool

func GetParent():
	self.get_parent()
