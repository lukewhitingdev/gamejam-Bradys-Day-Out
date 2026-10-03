extends TabContainer

@onready var Grid = $Hats/ScrollContainer/GridContainer
@export var GridItem: Resource = preload("res://UI/Components/DressUpGridItem.tscn");
@export var Items: Array[GridItemData] = []

var GridItemMinSize = Vector2(100, 100)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SetupGrid(GridItem)
	pass # Replace with function body.
	
func SetupGrid(Item):
	for item in Items:
		var node: AspectRatioContainer = CreateGridItem(GridItem)
		node.custom_minimum_size = GridItemMinSize
		Grid.add_child(node)

func CreateGridItem(Item) -> AspectRatioContainer:
	var node = GridItem.instantiate()
	return node as AspectRatioContainer
