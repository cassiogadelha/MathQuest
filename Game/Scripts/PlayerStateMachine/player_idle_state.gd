extends PlayerBaseState
class_name PlayerIdleState

@onready var foot_steps = $"../../FootSteps"
@onready var movement = $"../../Movement"

var direction
var input_dir

func Enter():
	foot_steps.stop()
	animation_player.play("Idle")
	
	#movement.stop_player()
	
func Update(_delta: float):
	if Input.is_action_just_pressed("Attack"):
		state_transition.emit(self, "playerAttackState")
	
	input_dir = Input.get_vector("Left", "Right", "Up", "Down")
	if input_dir.x != 0 or input_dir.y != 0:
		state_transition.emit(self, "playermovestate")
