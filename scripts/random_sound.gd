extends AudioStreamPlayer3D

@export var first_wait := 5.0   # seconds before the very first play
@export var min_wait := 15.0    # shortest pause between plays
@export var max_wait := 40.0    # longest pause between plays

var _timer := Timer.new()
var _stopped := false



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("random_ambience")
	_timer.one_shot = true
	# When the timer runs out, play the sound.
	_timer.timeout.connect(_on_timer_timeout)
	# When the sound finishes, start waiting for the next play.
	finished.connect(_schedule_next)
	add_child(_timer)
	_timer.start(first_wait)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
func _on_timer_timeout() -> void:
	play()


func _schedule_next() -> void:
	if _stopped:
		return
	_timer.start(randf_range(min_wait, max_wait))


func stop_for_good() -> void:
	_stopped = true
	_timer.stop()
	stop()
