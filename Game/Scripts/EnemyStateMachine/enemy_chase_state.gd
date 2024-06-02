extends EnemyBaseState
class_name EnemyChaseState

@onready var chase_state_timer = $"../ChaseStateTimer" as Timer
@onready var can_attack_area = $"../../Combat/CanAttackArea"

var direction: Vector3

func Enter():
	super.Enter()
	animation_player.play("Walk")
	chase_state_timer.start()

func Update(_delta):
	super.Update(_delta)
	
	navigation_agent.target_position = player.global_position
	direction = (navigation_agent.get_next_path_position() - my_self.global_position).normalized()
	
	enemy_movement.chase_target(direction, _delta)
	
	if can_attack_area.overlaps_body(player):
		state_transition.emit(self, "EnemyAttackState")
		
	if !navigation_agent.is_target_reachable():
		returned_from_chase_state = true
		state_transition.emit(self, "EnemyReturnState")

func _on_chase_state_timer_timeout():
	returned_from_chase_state = true
	state_transition.emit(self, "EnemyReturnState")
	
func Exit():
	super.Exit()
