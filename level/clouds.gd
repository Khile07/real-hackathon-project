extends TileMapLayer

var time : float = 0.0
var cycle : float = 2 * PI
var max : float = 256
var dir : int = 1
func _process(delta: float) -> void:
	position.x = sin(time) * 16
	time += delta
	if time > cycle: time = 0
	
