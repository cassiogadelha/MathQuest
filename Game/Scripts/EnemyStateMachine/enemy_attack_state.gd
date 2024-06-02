extends EnemyBaseState
class_name EnemyAttackState

@onready var bite = $"../../Bite" as AudioStreamPlayer3D
@onready var escape_attack_range_area = $"../../Combat/EscapeAttackRange" as Area3D

func Enter():
	super.Enter()
	
	animation_player["speed_scale"] = 0.5
	enemy_movement.stop()
	animation_player.play("Bite_Front")
	
func Exit():
	super.Exit()
	
	animation_player["speed_scale"] = 1
	
func Update(_delta):
	if player != null:
		if !escape_attack_range_area.overlaps_body(player):
			pass
			state_transition.emit(self, "EnemyChaseState")
	
func check_attack():
	if player != null:
		if escape_attack_range_area.overlaps_body(player):
			bite.play()
			player.get_damage(my_self.stats.damage)
		else:
			pass
			state_transition.emit(self, "EnemyChaseState")
