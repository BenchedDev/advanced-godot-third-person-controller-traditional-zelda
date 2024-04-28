class_name StateMachine extends State

@export var child_states : Array[State]
@export var get_states_from_children : bool = true
@export var initial_state : State

@export var top_machine : bool = true

var current_state : State:
	set(value):
		if(value in child_states):
			if(current_state):
				current_state.exit_state()
			current_state = value
			current_state.enter_state()

func _ready() -> void:
	if(top_machine):
		init_state()
		enter_state()

func _process(delta: float) -> void:
	if(top_machine): state_process(delta)

func _physics_process(delta: float) -> void:
	if(top_machine): state_physics_process(delta)

func init_state() -> void:
	if(get_states_from_children):
		for child in get_children():
			if(child is State):
				child_states.push_back(child)

	for state in child_states:
		state.change_state.connect(on_change_state)
		state.init_state()

func enter_state() -> void:
	if(initial_state):
		current_state = initial_state

func exit_state() -> void:
	pass

func state_process(delta : float) -> void:
	if(current_state): current_state.state_process(delta)

func state_physics_process(delta : float) -> void:
	if(current_state): current_state.state_physics_process(delta)

func on_change_state(new_state_name : String) -> void:
	for state in child_states:
		if(state.state_name == new_state_name):
			current_state = state
			return
