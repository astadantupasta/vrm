class_name Inventory
extends Area3D

var items: Array[String] = []

# Called 	when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	area_entered.connect(_on_area_entered)
	
func _on_body_entered(body: Node3D):
	print(body.name)
	if body.is_in_group("pickup"):
		add_item(body.name)
		body.queue_free()
		
	if body.has_method("try_drop_off"):
		body.try_drop_off(self)
		
	if body.has_method("player_entered"):
		body.player_entered(self)

func _on_area_entered(area: Area3D):
	print(area.name)
	if area.has_method("try_drop_off"):
		area.try_drop_off(self)
	
func _on_body_exited(body: Node3D):
	if body.has_method("player_exited"):
		body.player_exited(self)
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func add_item(item_name: String):
	items.append(item_name)
	
func remove_item(item_name: String):
	items.erase(item_name)

func has_item(item_name: String) -> bool:
	return items.has(item_name)
	
func is_inventory_empty() -> bool:
	return items.is_empty()
	
