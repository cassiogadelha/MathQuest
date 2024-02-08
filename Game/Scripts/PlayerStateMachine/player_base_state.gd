extends Node
class_name PlayerBaseState

signal state_transition
@onready var animation_player = $"../../Visuals/Mage/AnimationPlayer" as AnimationPlayer

func _ready():
	GlobalSignals.player_death.connect(enter_death_state)
	
func Enter():
	pass
	
func Exit():
	pass
	
func Update(_delta: float):
	pass

func enter_death_state():
	state_transition.emit(self, "PlayerDeathState")
