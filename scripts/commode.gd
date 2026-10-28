extends "res://scripts/dropoff.gd"

@export var door: Node3D               
@export var closed_z: float = 0.271    
@export var close_time: float = 1.0    

var _inventory: Inventory = null
var _closed := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func player_entered(inventory: Inventory) -> void:
	_inventory = inventory	

func player_exited(inventory: Inventory) -> void:
	if _inventory == inventory:
		_inventory = null

func _unhandled_input(event: InputEvent) -> void:
	if not (event is InputEventKey and event.pressed and not event.echo and event.keycode == KEY_C):
		return
	if _inventory == null or not _delivered or _closed:
		return
	_closed = true
	var tween := create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(door, "position:z", closed_z, close_time)
