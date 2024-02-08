extends Area3D
class_name HurtBox

signal damage_received

func take_damage(attack_details: AttackStates):
	damage_received.emit(attack_details)
	owner.health -= attack_details.damage
	
	if owner.health <= 0:
		print("DEATH")
