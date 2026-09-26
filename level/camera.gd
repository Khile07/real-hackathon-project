extends Camera2D


@onready var death_zone : Area2D = $Area2D

func _ready() -> void:
	death_zone.body_entered.connect(kill_someone)
	
func kill_someone(body : PhysicsBody2D):
	if body is player:
		body.call_deferred("queue_free")
