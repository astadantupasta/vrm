extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Plays a sound once, then deletes the sound node.
func play_sound_at(stream: AudioStream, pos: Vector3) -> void:
	if stream == null:
		return
	var player := AudioStreamPlayer3D.new()
	player.stream = stream
	player.position = pos
	get_tree().current_scene.add_child(player)
	player.finished.connect(player.queue_free)
	player.play()
