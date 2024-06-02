extends Node
class_name EnemyBaseState

signal state_transition

@onready var navigation_agent = $"../../NavigationAgent3D" as NavigationAgent3D
@onready var enemy_movement = $"../../EnemyMovement" as EnemyMovement
@onready var animation_player = $"../../Visuals/AnimationPlayer" as AnimationPlayer
@onready var hurt_box = $"../../Combat/HurtBox" as HurtBox
@onready var my_self = $"../.." as Enemy


var initial_position : Vector3
var returned_from_chase_state: bool = false
var attack_details = AttackStates.new()
var fsm: EnemyFiniteStateMachine

@onready var player = get_tree().get_nodes_in_group("Player")[0] as Player

func _ready():
	fsm = get_parent()
	
	if initial_position == Vector3.ZERO:
		initial_position = my_self.global_position

func Enter():
	GlobalSignals.player_death.connect(enter_return_state)
	hurt_box.damage_received.connect(get_hit)
	
func Exit():
	hurt_box.damage_received.disconnect(get_hit)
	GlobalSignals.player_death.disconnect(enter_return_state)	
	
func Update(_delta: float):
	pass

func get_hit(_attack_details: AttackStates):
	if fsm.current_state !=  EnemyAttackState:
		state_transition.emit(self, "EnemyChaseState")

func _on_area_3d_body_entered(_body):
	state_transition.emit(self, "EnemyChaseState")
	
func enter_return_state():
	state_transition.emit(self, "EnemyReturnState")
