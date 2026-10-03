extends TabContainer

@onready var Grid = $Hats/ScrollContainer/GridContainer
@export var GridItem: Resource = preload("res://UI/Components/TabAssetSelector/GridItem/DressUpGridItem.tscn");

@export var Items: Array[GridItemData] = []

var gridItems: Array[DressUpGridItem] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SetupGrid(GridItem)
	pass # Replace with function body.
	
func SetupGrid(res: Resource):
	for item in Items:
		var gridScript = Grid as GridContainerScript
		var gridItem = gridScript.add_grid_item(res)

		gridItems.append(gridItem as DressUpGridItem)

		gridScript.bind_events(gridItems)
