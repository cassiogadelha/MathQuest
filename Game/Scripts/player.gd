extends CharacterBody3D
class_name Player

#@onready var camera_mount = $CameraMount
@onready var animation_player = $Visuals/Mage/AnimationPlayer
@onready var visuals = $Visuals
@onready var spell_shoot = $SpellShoot
@onready var foot_steps = $FootSteps

@onready var phantom_camera_3d = %PhantomCamera3D

@onready var arcane_bolt_spawn_point = $Visuals/ArcaneBoltSpawnPoint
@onready var movement = $Movement

var arcane_bolt = preload("res://Scenes/arcane_bolt.tscn")
var instance

var sens_horizontal = 0.1
var direction

var health = 100

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED #remove mouse from screen
	
func _input(event):
	if event is InputEventMouseMotion:
		#rotate_y(deg_to_rad(-event.relative.x * sens_horizontal))
		#visuals.rotate_y(deg_to_rad(event.relative.x * sens_horizontal))
		
		#phantom_camera_3d.rotate_y(deg_to_rad(-event.relative.x * sens_horizontal))
		
		if(phantom_camera_3d.rotation.x >= 0.82):
			phantom_camera_3d.rotation.x = 0.82
			
		if(phantom_camera_3d.rotation.x <= -0.25):
			phantom_camera_3d.rotation.x = -0.25
	
func spawn_magic():
	spell_shoot.play()
	
	if movement.last_direction == null:
		movement.last_direction = Vector3.FORWARD
		
	instance = arcane_bolt.instantiate()
	get_parent().add_child(instance)
	
	instance.position = arcane_bolt_spawn_point.global_position
	instance.transform.basis = arcane_bolt_spawn_point.global_transform.basis
	
	instance.linear_velocity = movement.last_direction * 10
	
func play_foot_steeps():
	foot_steps.play()
	
func get_damage():
	health -= 0
	if health <= 0:
		GlobalSignals.player_death.emit()
