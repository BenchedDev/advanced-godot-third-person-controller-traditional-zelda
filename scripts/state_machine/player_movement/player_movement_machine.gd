class_name PlayerMovementMachine extends StateMachine

@export var movement : PlayerMovementComponent

func init_state() -> void:
	if(get_states_from_children):
		for child in get_children():
			if(child is State):
				child_states.push_back(child)

	for state in child_states:
		state.change_state.connect(on_change_state)
		if(state is PlayerMovementState):
			state.movement = movement
		state.init_state()
