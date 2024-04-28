extends PlayerMovementState

@export var fall_state_name := "Fall"

func enter_state() -> void:
	super.enter_state()
	movement.velocity.y = stats.jump_velocity
	var move_dir := movement.get_move_direction()
	movement.velocity.x = move_dir.x * stats.jump_speed
	movement.velocity.z = move_dir.z * stats.jump_speed
	if(movement.anim_player):
		movement.anim_player.stop()
		movement.anim_player.play("jump")

func state_physics_process(delta : float) -> void:
	super.state_physics_process(delta)
	movement.handle_gravity(delta)
	if(stats.air_control_enabled):
		movement.handle_air_control(delta)
	if(movement.velocity.y < 0):
		change_state.emit(fall_state_name)
		return
