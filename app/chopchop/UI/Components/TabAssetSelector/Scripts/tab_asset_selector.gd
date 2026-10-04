class_name TableAssetSelectorScript extends TabContainer

signal OnAssetSelected 

@onready var Grid = $Hats/ScrollContainer/GridContainer
@onready var ClickAudioStreamPlayer: AudioStreamPlayer = $ClickStreamPlayer
@export var GridItem: Resource = preload("res://UI/Components/TabAssetSelector/GridItem/DressUpGridItem.tscn");

@export var Items: Array[GridItemData] = []

var gridItems: Array[DressUpGridItem] = []

var itemsToData: Dictionary[AspectRatioContainer, GridItemData] = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Grid.OnItemSelected.connect(_on_item_selected)
	OnAssetSelected.connect(_on_asset_selected)
	SetupGrid(GridItem)
	pass # Replace with function body.
	
func _on_asset_selected(_data):
	ClickAudioStreamPlayer.play()

func _on_item_selected(item: DressUpGridItem):
	var data = itemsToData.get(item)
	if(data != null):
		OnAssetSelected.emit(data as GridItemData)

func SetupGrid(res: Resource):

	var gridScript = Grid as GridContainerScript
	for data in Items:
		var gridItem = gridScript.add_grid_item(res)

		if(itemsToData.get(gridItem) == null):
			itemsToData.set(gridItem, data)

		var gridItemScript = gridItem as DressUpGridItem
		gridItemScript.set_data(data)
		gridItems.append(gridItemScript)

	gridScript.bind_events(gridItems)
