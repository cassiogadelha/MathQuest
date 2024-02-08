extends CharacterBody3D
class_name Enemy

@export var stats: EntityStats

var radius = 5.0
var health : float

func _ready():
	health = stats.health
