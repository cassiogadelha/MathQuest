extends CharacterBody3D
class_name Enemy

@onready var health_bar = %HealthBar
@onready var teste = $Teste

@export var stats: EntityStats

var radius:float = 5
var health:float

func _ready():
	health = stats.health
	health_bar.init_health(stats.health)

func _on_teste_timeout():
	health -= 20
	if health_bar != null:
		health_bar.health = health
