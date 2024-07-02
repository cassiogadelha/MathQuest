extends EnemyBaseState
class_name EnemyReturnState

var direction: Vector3


func destiny_reached():
	state_chart.send_event("destiny_reached")


func _on_return_state_entered():
	super.Enter()
	
	navigation_agent.target_position = initial_position
	navigation_agent.target_reached.connect(destiny_reached)


func _on_return_state_processing(delta):
	direction = (navigation_agent.get_next_path_position() - my_self.global_position).normalized()
	enemy_movement.move(direction, delta, navigation_agent.distance_to_target(), true)


func _on_return_state_exited():
	navigation_agent.target_reached.disconnect(destiny_reached)
	super.Exit()
