extends PlayerMovementState

@export var fall_state_name := "Fall"
@export var walk_state_name := "Walk"

func enter_state() -> void:
	super.enter_state()
	movement.velocity = Vector3.ZERO
	if(movement.anim_player):
		movement.anim_player.stop()
		movement.anim_player.play("idle")

func state_physics_process(delta : float) -> void:
	super.state_physics_process(delta)
	movement.handle_gravity(delta)
	if(not(movement.body.is_on_floor())):
		change_state.emit(fall_state_name)
		return
	if(movement.input.get_input_direction()):
		change_state.emit(walk_state_name)
		return
