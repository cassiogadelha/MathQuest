extends PlayerBaseState
class_name PlayerAttackState

@onready var foot_steps = $"../../FootSteps"
@onready var movement = $"../../Movement" as Movement

func Enter():
	movement.stop_player()
	animation_player.play("Spellcast_Shoot")
	
func Update(_delta):
	movement.stop_player()
	
func finish_attack():
	state_transition.emit(self, "playerIdleState")

func Exit():
	set_physics_process(true)
	set_process_unhandled_input(true)
