extends ProgressBar
class_name HealthBar


@onready var damage_bar_timer = %DamageBarTimer
@onready var damage_bar = %DamageBar

var health:float = 100 : set = set_health

func set_health(new_health) -> void:
	var prev_health = health
	health = min(max_value, new_health)
	value = health
	
	if health <= 0:
		queue_free()	
		
	if health < prev_health: #taking damage
		damage_bar_timer.start()
	else: #healing
		damage_bar.value = health

func init_health(_health) -> void:
	health = _health
	max_value = health
	value = health
	damage_bar.max_value = health
	damage_bar.value = health

func _on_damage_bar_timer_timeout():
	damage_bar.value = health
