extends EnemyBaseState
class_name EnemyReturnState

var direction: Vector3

func Enter():
	super.Enter()
	
	animation_player.play("Walk")
	navigation_agent.target_position = initial_position
	navigation_agent.target_reached.connect(destiny_reached)
	
func destiny_reached():
	state_transition.emit(self, "EnemyIdleState")
	
func Update(_delta: float):
	direction = (navigation_agent.get_next_path_position() - my_self.global_position).normalized()
	enemy_movement.move(direction, _delta, navigation_agent.distance_to_target())
	
func Exit():
	super.Exit()
