extends Node3D
class_name Movement

@onready var player = $".." as Player
const SPEED = 7.0
@onready var visuals = $"../Visuals"

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var direction
var last_direction

func _physics_process(delta):
	if not player.is_on_floor():
		player.velocity.y -= gravity * delta
		
	player.move_and_slide()
		
func stop_player():
	if player != null:
		player.velocity.x = move_toward(player.velocity.x, 0, SPEED)
		player.velocity.z = move_toward(player.velocity.z, 0, SPEED)

func move_player(input_dir: Vector2):
	direction = (player.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	player.velocity.x = direction.x * SPEED
	player.velocity.z = direction.z * SPEED
		
	if direction != Vector3.ZERO:
		last_direction = direction
		visuals.look_at(player.position + direction)
