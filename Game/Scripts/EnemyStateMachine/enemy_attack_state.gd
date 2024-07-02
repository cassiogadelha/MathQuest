extends EnemyBaseState
class_name EnemyAttackState

@onready var bite = $"../../Bite" as AudioStreamPlayer3D
@onready var escape_attack_range_area = $"../../Combat/EscapeAttackRange" as Area3D

func check_attack():
	if player != null:
		if escape_attack_range_area.overlaps_body(player):
			bite.play()
			player.get_damage()
		else:
			state_chart.send_event("chase")


func _on_attack_state_entered():
	super.Enter()
	
	animation_player["speed_scale"] = 0.5
	enemy_movement.stop()


func _on_attack_state_processing(delta):
	if player != null:
		if !escape_attack_range_area.overlaps_body(player):
			state_chart.send_event("chase")
			

func _on_attack_state_exited():
	super.Exit()
	
	animation_player["speed_scale"] = 1
