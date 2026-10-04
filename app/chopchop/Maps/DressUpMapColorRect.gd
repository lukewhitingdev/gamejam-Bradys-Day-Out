extends ColorRect

@onready var footer = $VBoxContainer/SaveFooter
@onready var assetSelector = $VBoxContainer/TabAssetSelector

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var footerScript = footer as SaveFooterScript
	footerScript.OnFoldChanged.connect(_on_fold_changed)

func _on_fold_changed(value: bool):
	if(value):
		assetSelector.hide()
		mouse_filter = Control.MOUSE_FILTER_IGNORE
		self.color.a = 0
	else:
		assetSelector.show()
		mouse_filter = Control.MOUSE_FILTER_PASS
		self.color.a = 255 
