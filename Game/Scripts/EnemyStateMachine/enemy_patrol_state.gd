extends EnemyBaseState
class_name EnemyPatrolState

var has_moved_away_initial_position := false
var direction: Vector3
	
func destiny_reached():
	state_chart.send_event("destiny_reached")
	
func get_random_position() -> Vector3:
	var theta = 2 * PI * randf()
	var phi = PI * randf()
	
	var x = sin(phi) * cos(theta) * 7
	var y = my_self.position.y
	var z = cos(phi) * 7
	print(x, "   ", y, "    ", z)
	
	return Vector3(x, y, z)

func _on_patrol_state_entered():
	super.Enter()
	
	state_chart.send_event("movement")
	
	if has_moved_away_initial_position or returned_from_chase_state:
		navigation_agent.target_position = initial_position
		has_moved_away_initial_position = false
		returned_from_chase_state = false
	else:
		navigation_agent.target_position = my_self.global_position + get_random_position()
		has_moved_away_initial_position = true
		
	navigation_agent.target_reached.connect(destiny_reached)

func _on_patrol_state_processing(delta):
	direction = (navigation_agent.get_next_path_position() - my_self.global_position).normalized()
	enemy_movement.move(direction, delta, navigation_agent.distance_to_target(), false)


func _on_patrol_state_exited():
	super.Exit()
	
	navigation_agent.target_reached.disconnect(destiny_reached)
