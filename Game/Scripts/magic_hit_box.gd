extends Area3D
class_name MagicHitBox

@export var attack_details: AttackStates

func _on_area_entered(area: HurtBox):
	attack_details.attacker_position = owner.global_position
	
	area.take_damage(attack_details)
	owner.queue_free()
