extends PlayerBaseState
class_name PlayerMoveState

@onready var movement = $"../../Movement"
var input_dir

func Enter():
	animation_player.play("Running_A")
	
func Update(_delta: float):
	if Input.is_action_just_pressed("Attack"):
		state_transition.emit(self, "playerAttackState")
		
	input_dir = Input.get_vector("Left", "Right", "Up", "Down")
	
	movement.move_player(input_dir)
	
	if input_dir == Vector2.ZERO:
		state_transition.emit(self, "playerIdleState")
		
