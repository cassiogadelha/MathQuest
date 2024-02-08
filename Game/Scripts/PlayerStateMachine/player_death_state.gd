extends PlayerBaseState
class_name PlayerDeathState

func Enter():
	super.Enter()
	
	animation_player.play("Death_A")
	
func destroy_player():
	owner.queue_free()
