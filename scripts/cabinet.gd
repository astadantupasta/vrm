extends Node

@export var door: Node3D                
@export var hidden_item: Node3D        
@export var required_item: String = "Vintage binocular"
@export var open_angle: float = 90.0    
@export var door_time: float = 1.0       # seconds to open or close
@export var closed_angle: float = 4.6

var _inventory: Inventory = null
var _is_open := false
var _placed := false
var _tween: Tween

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hidden_item.visible = false
	
func player_entered(inventory: Inventory):
	_inventory = inventory

func player_exited(inventory: Inventory):
	if _inventory == inventory:
		_inventory = null

func _unhandled_input(event: InputEvent) -> void:
	if _inventory == null: return
	if event is InputEventKey and event.pressed and not event.echo:
		match event.keycode:
			KEY_O: open_door()
			KEY_P: place_item()
			KEY_C: close_door()

func open_door():
	if _is_open: return
	_rotate_door_to(closed_angle + open_angle)
	_is_open = true
	
func close_door():
	if not _is_open: return
	_rotate_door_to(closed_angle)
	_is_open = false

func place_item():
	if _placed: return
	if not _inventory.has_item(required_item):
		print("ITEM NOT FOUND ", required_item)
		return
	_inventory.remove_item(required_item)
	hidden_item.visible = true
	_placed = true
	print(required_item, " PLACED")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _rotate_door_to(angle: float) -> void:
	if _tween:
		_tween.kill()
	_tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	_tween.tween_property(door, "rotation_degrees:y", angle, door_time)
