extends EnemyBaseState
class_name EnemyIdleState

@onready var idle_state_timer = $"../IdleStateTimer"

var direction
var input_dir
	
func Enter():
	super.Enter()
	
	animation_player.play("Idle")
	idle_state_timer.start()
	
	enemy_movement.stop()

func _on_idle_state_timer_timeout():
	state_transition.emit(self, "EnemyMoveState")
	
func Update(_delta):
	enemy_movement.stop()
	
func Exit():
	super.Exit()
