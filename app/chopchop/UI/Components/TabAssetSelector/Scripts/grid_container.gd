class_name GridContainerScript extends GridContainer

var hasItemSelected = false
var currentSelectedItem: DressUpGridItem

signal OnItemSelected

var GridItemMinSize = Vector2(100, 100)

# Called when the node enters the scene tree for the first time.
func bind_events(items: Array[DressUpGridItem]) -> void:
	for item in items:
		item.OnSelected.connect(_on_item_selected)

# Adds a item to the grid and returns the item reference
func add_grid_item(res: Resource):
	var variant = CreateGridItem(res)
	var node: AspectRatioContainer = variant as AspectRatioContainer
	node.custom_minimum_size = GridItemMinSize
	self.add_child(node)

	return node

func CreateGridItem(res: Resource) -> AspectRatioContainer:
	var node = res.instantiate()
	return node as AspectRatioContainer

func _on_item_selected(item: DressUpGridItem):
	var bItemIsCurrentlySelected = item == currentSelectedItem

	if(hasItemSelected && !bItemIsCurrentlySelected):
		currentSelectedItem._on_unslect()

	currentSelectedItem = item
	hasItemSelected = true

	OnItemSelected.emit(item)
