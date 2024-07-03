extends CharacterBody3D
class_name Enemy

@onready var health_bar = %HealthBar
@onready var teste = $Teste

@export var stats: EntityStats

var radius = 5.0
var health : float

func _ready():
	health = stats.health
	health_bar.init_health(stats.health)
	print(health_bar.health)

func _on_teste_timeout():
	health_bar.health = 20
