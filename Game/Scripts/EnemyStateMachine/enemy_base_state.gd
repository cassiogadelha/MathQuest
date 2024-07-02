extends Node
class_name EnemyBaseState

@onready var navigation_agent = $"../../NavigationAgent3D" as NavigationAgent3D
@onready var enemy_movement = $"../../EnemyMovement" as EnemyMovement
@onready var animation_player = $"../../Visuals/AnimationPlayer" as AnimationPlayer
@onready var hurt_box = $"../../Combat/HurtBox" as HurtBox
@onready var my_self = $"../.." as CharacterBody3D
@onready var state_chart = %StateChart as StateChart

var initial_position := Vector3.ZERO
var returned_from_chase_state: bool = false
var attack_details = AttackStates.new()

@onready var player = get_tree().get_nodes_in_group("Player")[0] as Player

func _ready():
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
	pass
	#if fsm.current_state !=  EnemyAttackState:
		#state_transition.emit(self, "EnemyChaseState")
	
func enter_return_state():
	state_chart.send_event("return")

func _on_chase_player_area_body_entered(body):
	state_chart.send_event("chase")
