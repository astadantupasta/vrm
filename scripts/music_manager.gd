extends Node

@export var intro_stream: AudioStream   # 10sec-beginning.mp3
@export var main_stream: AudioStream    # royal.mp3
@export var end_stream: AudioStream     # end.wav

@export var intro_length := 10.0        
@export var fade_time := 1.5            
@export var music_volume_db := -6.0     

var _intro := AudioStreamPlayer.new()
var _main := AudioStreamPlayer.new()
var _end := AudioStreamPlayer.new()

var _ended := false



# Called when the node enters the scene tree for the first time.
func _ready() -> void:	
	add_to_group("music")
	
	_intro.stream = intro_stream
	_main.stream = main_stream
	_end.stream = end_stream
	_intro.volume_db = music_volume_db
	_main.volume_db = music_volume_db
	_end.volume_db = music_volume_db
	add_child(_intro)
	add_child(_main)
	add_child(_end)
	
	# 1-Start the intro.
	_intro.play()

	# 2-Wait until it is time to fade, then fade it out.
	await get_tree().create_timer(intro_length - fade_time).timeout
	if _ended:
		return
	_fade_out(_intro, fade_time)

	# 3-Wait for the fade to finish, then start royal.
	await get_tree().create_timer(fade_time).timeout
	if _ended:
		return
	_main.play()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
# Called by the picture frame when it has turned
func play_ending() -> void:
	if _ended:
		return
	_ended = true
	_fade_out(_intro, 0.5)
	_fade_out(_main, 0.5)
	get_tree().call_group("random_ambience", "stop_for_good")
	_end.play()


# Fate out the music
func _fade_out(player: AudioStreamPlayer, time: float) -> void:
	if not player.playing:
		return
	var tween := create_tween()
	tween.tween_property(player, "volume_db", -60.0, time)
	tween.tween_callback(player.stop)
