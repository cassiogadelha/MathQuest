extends EnemyBaseState
class_name EnemyChaseState

@onready var chase_state_timer = $"../ChaseStateTimer" as Timer
@onready var can_attack_area = $"../../Combat/CanAttackArea"

var direction: Vector3

func _on_chase_state_timer_timeout():
	returned_from_chase_state = true
	state_chart.send_event("chase_timeout")
	

func _on_chase_state_entered():
	super.Enter()
	state_chart.send_event("movement")
	chase_state_timer.start()


func _on_chase_state_processing(delta):
	super.Update(delta)
	
	navigation_agent.target_position = player.global_position
	direction = (navigation_agent.get_next_path_position() - my_self.global_position).normalized()
	
	enemy_movement.chase_target(direction, delta)
	
	if can_attack_area.overlaps_body(player):
		state_chart.send_event("attack")
		
	if !navigation_agent.is_target_reachable():
		state_chart.send_event("return")


func _on_chase_state_exited():
	super.Exit()
