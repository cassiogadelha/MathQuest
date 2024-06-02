extends Area3D
class_name TargetArea

var near_enemies: Array = []

@onready var player = $".." as Player

var nearest_enemy: Enemy

func _on_body_entered(body):
	if body is Enemy:
		near_enemies.append(body)

func _on_body_exited(body):
	if body in near_enemies:
		near_enemies.remove_at(near_enemies.find(body))

func get_nearest_enemy() -> Enemy:
	if !near_enemies.is_empty():
		nearest_enemy = near_enemies[0]
		for enemy: Enemy in near_enemies:
			if player.global_position.distance_to(enemy.global_position) < player.global_position.distance_to(nearest_enemy.global_position):
				nearest_enemy = enemy
				
	return nearest_enemy
