extends Node
class_name EnemyFiniteStateMachine

var states : Dictionary = {}

@onready var hurt_box = $"../Combat/HurtBox" as HurtBox

@export var initial_state: EnemyBaseState
var current_state: EnemyBaseState

func _ready():
	for child in get_children():
		if child is EnemyBaseState:
			states[child.name.to_lower()] = child
			child.state_transition.connect(change_state)
			
	if initial_state:
		initial_state.Enter()
		current_state = initial_state
		
func _process(delta):
	if current_state:
		current_state.Update(delta)
		
	#print("CURRENT STATE: ", current_state)
		
func change_state(source_state: EnemyBaseState, new_state_name: String):
	if source_state != current_state:
		print("SAME STATE! ENEMY")
		return
	var new_state = states.get(new_state_name.to_lower())
	
	if !new_state:
		print("STATE DOESN'T EXIST!")
		return
		
	if current_state:
		current_state.Exit()
		
	new_state.Enter()
	
	current_state = new_state
	
