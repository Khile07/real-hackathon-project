extends Node

@export var wave_audio_tracks : AudioStreamSynchronized

var current_level: int #1, 2, 3, 4, 5
var music_volume: int
var sfx_volume: int

var music_bus = AudioServer.get_bus_index("Music")
var sfx_bus = AudioServer.get_bus_index("SFX")

func _ready() -> void:
	wave_audio_tracks.set_sync_stream_volume(0, -60)
	wave_audio_tracks.set_sync_stream_volume(1, -60)
	wave_audio_tracks.set_sync_stream_volume(2, -60)
	wave_audio_tracks.set_sync_stream_volume(3, -60)
	wave_audio_tracks.set_sync_stream_volume(4, -60)
	
	SignalManager.wave_1_started.connect(_wave_1_start)
	SignalManager.wave_2_started.connect(_wave_2_start)
	SignalManager.wave_3_started.connect(_wave_3_start)
	SignalManager.wave_4_started.connect(_wave_4_start)
	SignalManager.wave_5_started.connect(_wave_5_start)
	
	SignalManager.wave_1_ended.connect(_wave_1_end)
	SignalManager.wave_2_ended.connect(_wave_2_end)
	SignalManager.wave_3_ended.connect(_wave_3_end)
	SignalManager.wave_4_ended.connect(_wave_4_end)
	SignalManager.wave_5_ended.connect(_wave_5_end)

func _wave_1_start() -> void:
	wave_audio_tracks.set_sync_stream_volume(0, 0)
func _wave_2_start() -> void:
	wave_audio_tracks.set_sync_stream_volume(2, 0)
func _wave_3_start() -> void:
	wave_audio_tracks.set_sync_stream_volume(3, 0)
func _wave_4_start() -> void:
	pass
func _wave_5_start() -> void:
	pass

func _wave_1_end() -> void:
	wave_audio_tracks.set_sync_stream_volume(0, -60)

func _wave_2_end() -> void:
	wave_audio_tracks.set_sync_stream_volume(1, -60)

func _wave_3_end() -> void:
	wave_audio_tracks.set_sync_stream_volume(2, -60)

func _wave_4_end() -> void:
	pass

func _wave_5_end() -> void:
	pass
