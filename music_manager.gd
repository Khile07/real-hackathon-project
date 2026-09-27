extends Node
class_name music_manager

@onready var base : AudioStreamPlayer = $base_song_player
@onready var plus_1 : AudioStreamPlayer = $plus_1_player
@onready var plus_2 : AudioStreamPlayer = $plus_2_player

var num_track : Dictionary[int, AudioStreamPlayer]
var fading_out_tracks : Dictionary[AudioStreamPlayer, int] 
var fading_in_tracks : Dictionary[AudioStreamPlayer, int]

func _ready() -> void:
	num_track[0] = base
	num_track[1] = plus_1
	num_track[2] = plus_2
	SignalManager.pause_open.connect( func(): fade_out([1]))
	SignalManager.pause_close.connect( func(): fade_in([0,1]))
	SignalManager.wave_started.connect(func (): fade_in([0,1,2]))
	SignalManager.wave_ended.connect(func (): fade_out([2]))
	
	
func fade_out(tracks : Array[int] = []):
	for t in tracks:
		var track = num_track[t]
		if track in fading_in_tracks: fading_in_tracks.erase(track)
		fading_out_tracks[track] = 0
	
func fade_in(tracks : Array[int] = []):
	for t in tracks:
		var track = num_track[t]
		if track in fading_out_tracks: fading_out_tracks.erase(track)
		fading_in_tracks[track] = 0

func _process(delta: float) -> void:
	for track : AudioStreamPlayer in fading_out_tracks:
		if track.volume_db > -80: track.volume_db -= delta * 60
	for track : AudioStreamPlayer in fading_in_tracks:
		if track.volume_db < -3: track.volume_db += delta * 60
		
