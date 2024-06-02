extends EnemyBaseState
class_name EnemyMoveState

var has_moved_away_initial_position := false
var direction: Vector3
	
func Enter():
	super.Enter()
	
	animation_player.play("Walk")
	
	if has_moved_away_initial_position or returned_from_chase_state:
		navigation_agent.target_position = initial_position
		has_moved_away_initial_position = false
		returned_from_chase_state = false
	else:
		navigation_agent.target_position = my_self.global_position + get_random_position()
		has_moved_away_initial_position = true
		
	navigation_agent.target_reached.connect(destiny_reached)
	
func Update(_delta: float):
	direction = (navigation_agent.get_next_path_position() - my_self.global_position).normalized()
	enemy_movement.move(direction, _delta, navigation_agent.distance_to_target())
	
func destiny_reached():
	state_transition.emit(self, "EnemyIdleState")
	
func get_random_position() -> Vector3:
	var theta = 2 * PI * randf()
	var phi = PI * randf()
	
	var x = sin(phi) * cos(theta) * 7
	var y = my_self.position.y
	var z = cos(phi) * 7
	
	return Vector3(x, y, z)
	
func Exit():
	super.Exit()
	
	navigation_agent.target_reached.disconnect(destiny_reached)
