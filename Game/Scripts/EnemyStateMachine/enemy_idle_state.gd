extends EnemyBaseState
class_name EnemyIdleState

@onready var idle_state_timer = %IdleStateTimer

var direction
var input_dir

func _on_idle_state_timer_timeout():
	state_chart.send_event("timeout")
	

func _on_idle_state_entered():
	super.Enter()
	
	animation_player.play("Idle")
	idle_state_timer.start()

func _on_idle_state_processing(delta):
	enemy_movement.stop()


func _on_idle_state_exited():
	super.Exit()
