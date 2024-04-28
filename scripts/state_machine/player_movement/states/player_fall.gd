extends PlayerMovementState

@export var idle_state_name := "Idle"
@export var ledge_state_name := "Ledge"
@export var head_ray : RayCast3D
@export var head_down_ray : RayCast3D

func init_state() -> void:
	super.init_state()
	assert(head_ray and head_down_ray)


func state_physics_process(delta : float) -> void:
	super.state_physics_process(delta)
	movement.handle_gravity(delta)
	if(stats.air_control_enabled):
		movement.handle_air_control(delta)
	if(movement.body.is_on_floor()):
		change_state.emit(idle_state_name)
		return

	#should ledge grab
	head_ray.force_raycast_update()
	if(head_ray.is_colliding()):
		head_down_ray.force_raycast_update()
		if(head_down_ray.is_colliding()):
			#check the diffrence between our move direction and the ledge direction
			var move_dir = movement.get_move_direction()
			if(move_dir):
				print(move_dir.dot(head_ray.get_collision_normal()))
				if(move_dir.dot(head_ray.get_collision_normal()) < -.9):
					change_state.emit(ledge_state_name)
					return
