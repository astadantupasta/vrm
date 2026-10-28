extends Node

@export var straighten_time: float = 1.0
@export var rotation_degrees_z: float = 0.0

var _done := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func player_entered(_inventory: Inventory):
	if _done: return
	_done = true
	var tween := create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "rotation_degrees:z", rotation_degrees_z, straighten_time)
