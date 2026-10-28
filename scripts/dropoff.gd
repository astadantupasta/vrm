extends Node

@export var required_item: String = ""   
@export var reveal_node: Node3D          
@export var consume_item: bool = true 

var _delivered := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func try_drop_off(inventory: Inventory) -> void:
	if _delivered: return
	if not inventory.has_item(required_item):
		print("NOT FOUND ", required_item)
		return
		
	reveal_node.visible = true
	if consume_item:
		inventory.remove_item(required_item)
	_delivered = true
	print(required_item, " DROPPED AT ", name)
