extends CharacterBody3D
class_name Player

@onready var targets_area = $TargetsArea as TargetArea

@onready var text_damage_point = $TextDamagePoint as Marker3D
@export var damageText: PackedScene

#@onready var camera_mount = $CameraMount
@onready var animation_player = $Visuals/Mage/AnimationPlayer
@onready var visuals = $Visuals
@onready var spell_shoot = $SpellShoot
@onready var foot_steps = $FootSteps

#@onready var camera_mount = $"../PhantomCamera3D"
@onready var arcane_bolt_spawn_point = $Visuals/ArcaneBoltSpawnPoint
@onready var movement = $Movement

var arcane_bolt = preload("res://Scenes/arcane_bolt.tscn")
var instance

var sens_horizontal = 0.1
var direction

var health = 100

var previousSelection: Enemy

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED #remove mouse from screen
	
func _process(_delta):
	if Input.is_action_just_pressed("Select"):
		if previousSelection != null:
			previousSelection.selection_arrow.visible = false
			
		var nearestEnemy: Enemy = targets_area.get_nearest_enemy()
		
		if nearestEnemy != null:
			nearestEnemy.selection_arrow.visible = true
			previousSelection = nearestEnemy
	print(text_damage_point.global_position)
		
func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * sens_horizontal))
		visuals.rotate_y(deg_to_rad(event.relative.x * sens_horizontal))
		
		#camera_mount.rotate_y(deg_to_rad(-event.relative.x * sens_horizontal))
		
		#if(camera_mount.rotation.x >= 0.82):
			#camera_mount.rotation.x = 0.82
			
		#if(camera_mount.rotation.x <= -0.25):
			#camera_mount.rotation.x = -0.25
	
func spawn_magic():
	spell_shoot.play()
	
	if movement.last_direction == null:
		movement.last_direction = Vector3.FORWARD
		
	instance = arcane_bolt.instantiate()
	get_parent().add_child(instance)
	
	instance.position = arcane_bolt_spawn_point.global_position
	instance.transform.basis = arcane_bolt_spawn_point.global_transform.basis
	
	instance.linear_velocity = movement.last_direction * 10
	
func play_foot_steeps() -> void:
	foot_steps.play()
	
func get_damage(damageAmount: float) -> void:
	health -= damageAmount
	
	instance = damageText.instantiate() as Label3D
	text_damage_point.add_child(instance)
	instance.text = str(damageAmount)
	
	if health <= 0:
		GlobalSignals.player_death.emit()
