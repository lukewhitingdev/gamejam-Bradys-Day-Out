class_name DressUpGridItem extends AspectRatioContainer

@onready var BackgroundColorRect: ColorRect = $ColorRect
@onready var ItemImageTex: TextureRect = $VBoxContainer/MarginContainer/TextureRect
@onready var ItemLabel: RichTextLabel = $VBoxContainer/HBoxContainer/RichTextLabel

# Fired internally when object is selected, ARGS: [0] CurrentObject 
signal OnSelected

# Fired externally when new object is selected
signal UnSelect 

func _ready() -> void:
	OnSelected.connect(_on_selected)
	UnSelect.connect(_on_unslect)

	add_to_group(GroupNames.DressUpItemGroupName)

func set_data(data: GridItemData):
	ItemImageTex.texture = data.AssetImage
	ItemLabel.text = data.Name
	pass

func _on_gui_input(event: InputEvent) -> void:
	if (event.is_action_pressed("Left_Click")):
		OnSelected.emit(self as DressUpGridItem)
		
func _on_unslect():
	BackgroundColorRect.hide()


func _on_selected(_item):
	if(!BackgroundColorRect.visible):
		BackgroundColorRect.show()
	else:
		BackgroundColorRect.hide()
