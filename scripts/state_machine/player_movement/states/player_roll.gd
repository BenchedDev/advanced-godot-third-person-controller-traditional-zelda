extends PlayerMovementState


@export var walk_state_name := "Walk"
@export var jump_state_name := "Jump"
@export var ground_ray : RayCast3D

var duration : float = 0.0


func init_state() -> void:
	super.init_state()
	assert(ground_ray)

func enter_state() -> void:
	super.enter_state()
	var move_dir := movement.get_move_direction()
	movement.velocity.x = move_dir.x * stats.roll_speed
	movement.velocity.z = move_dir.z * stats.roll_speed
	if(move_dir):
		movement.model_container.rotation.y = atan2(movement.velocity.x, movement.velocity.z)
	duration = 0.0
	if(movement.anim_player):
		movement.anim_player.stop()
		movement.anim_player.play("roll")

func state_physics_process(delta: float) -> void:
	movement.handle_gravity(delta)
	duration += delta
	if(duration >= stats.roll_duration):
		change_state.emit(walk_state_name)
		return
	#should jump
	ground_ray.force_raycast_update()
	if(not(ground_ray.is_colliding())):
		#should jump
		change_state.emit(jump_state_name)
		return

func on_confirm() -> void:
	if(duration > stats.roll_duration * stats.roll_buffer_percentage):
		change_state.emit(state_name)
