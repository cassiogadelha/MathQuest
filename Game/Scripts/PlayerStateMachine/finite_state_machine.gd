extends Node
class_name FiniteStateMachine

var states : Dictionary = {}

@export var initial_state: PlayerBaseState
var current_state: PlayerBaseState

func _ready():
	for child in get_children():
		if child is PlayerBaseState:
			states[child.name.to_lower()] = child
			child.state_transition.connect(change_state)
			
	if initial_state:
		initial_state.Enter()
		current_state = initial_state
		
func _process(delta):
	if current_state:
		current_state.Update(delta)
		
func change_state(source_state: PlayerBaseState, new_state_name: String):
	if source_state != current_state:
		print("SAME STATE!")
		return
	var new_state = states.get(new_state_name.to_lower())
	
	if !new_state:
		print("STATE DOESN'T EXIST!")
		return
		
	if current_state:
		current_state.Exit()
		
	new_state.Enter()
	
	current_state = new_state
