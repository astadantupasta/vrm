extends Node3D

@export var straighten_time: float = 1.0
@export var rotation_degrees_z: float = 0.0
@export var straighten_sound: AudioStream

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
	FX.play_sound_at(straighten_sound, global_position)
	var tween := create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "rotation_degrees:z", rotation_degrees_z, straighten_time)
	tween.finished.connect(_on_turn_finished)

func _on_turn_finished():
	get_tree().call_group("music", "play_ending")
