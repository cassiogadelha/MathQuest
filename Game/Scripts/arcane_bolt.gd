extends RigidBody3D

@export var stats: MagicStats

func _on_life_time_timeout():
	queue_free()
