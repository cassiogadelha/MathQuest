extends Node3D
class_name EnemyMovement

const MOVE_SPEED = 3.0
const ACCEL = 10.0
const CHASE_SPEED = 4.5

@onready var enemy = $".." as CharacterBody3D
@onready var visuals = $"../Visuals"
@onready var hurt_box = $"../Combat/HurtBox" as HurtBox

var last_direction
var initial_position : Vector3
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var speed: float

func _physics_process(delta):
	if not enemy.is_on_floor():
		enemy.velocity.y -= gravity * delta
	
	enemy.move_and_slide()
	
func stop():
	if enemy != null:
		enemy.velocity = Vector3.ZERO

func move(direction: Vector3, _delta, distance_to_target: float, returning: bool):
	if returning:
		speed = MOVE_SPEED * 2
	else:
		speed = MOVE_SPEED
	#direction = (enemy.transform.basis * Vector3(random_axis.x, 0, random_axis.y)).normalized()
	enemy.velocity = enemy.velocity.lerp(direction * speed * 1.5, ACCEL * _delta)
	
	if direction != Vector3.ZERO:
		last_direction = direction
	
	if distance_to_target > 2.0:
		visuals.look_at(enemy.position + direction)
		
func chase_target(direction: Vector3, _delta: float):
	speed = CHASE_SPEED
	
	visuals.look_at(enemy.position + direction)
	enemy.velocity = enemy.velocity.lerp(direction * speed * 1.5, ACCEL * _delta)
