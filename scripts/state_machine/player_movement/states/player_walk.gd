extends PlayerMovementState

@export var fall_state_name := "Fall"
@export var idle_state_name := "Idle"
@export var jump_state_name := "Jump"
@export var obstacle_hop_state_name := "ObstacleHop"
@export var ledge_state_name := "Ledge"
@export var roll_state_name := "Roll"

@export_group("Rays")
@export var ground_ray : RayCast3D
@export var foot_ray : RayCast3D
@export var chest_ray : RayCast3D
@export var head_ray : RayCast3D
@export var head_down_ray : RayCast3D

var hop_buffer : float = 0.0
var ledge_buffer : float = 0.0

func init_state() -> void:
	super.init_state()
	assert(ground_ray)
	assert(foot_ray)
	assert(chest_ray)
	assert(head_ray)
	assert(head_down_ray)
	ground_ray.enabled = false
	foot_ray.enabled = false
	chest_ray.enabled = false
	head_ray.enabled = false
	head_down_ray.enabled = false

func enter_state() -> void:
	super.enter_state()
	hop_buffer = 0.0
	ledge_buffer = 0.0

func state_physics_process(delta : float) -> void:
	super.state_physics_process(delta)
	movement.handle_gravity(delta)

	var move_dir := movement.get_move_direction()
	movement.velocity.x = stats.move_speed * move_dir.x * delta
	movement.velocity.z = stats.move_speed * move_dir.z * delta
	if(move_dir):
		movement.model_container.rotation.y = atan2(movement.velocity.x, movement.velocity.z)
		movement.movement_spatial.rotation.y = atan2(movement.velocity.x, movement.velocity.z)
	#should fall
	if(not(movement.body.is_on_floor())):
		change_state.emit(fall_state_name)
		return

	#should jump
	ground_ray.force_raycast_update()
	if(not(ground_ray.is_colliding())):
		#should jump
		change_state.emit(jump_state_name)
		return

	#should obstacle hop
	foot_ray.force_raycast_update()
	if(foot_ray.is_colliding()):
		chest_ray.force_raycast_update()
		if(not(chest_ray.is_colliding())):
			#should obstacle hop
			hop_buffer += delta
			if(hop_buffer >= stats.hop_buffer):
				change_state.emit(obstacle_hop_state_name)
				return

	#should ledge grab
	head_ray.force_raycast_update()
	if(head_ray.is_colliding()):
		head_down_ray.force_raycast_update()
		if(head_down_ray.is_colliding()):
			#grab the ledge after a buffer
			ledge_buffer += delta
			if(ledge_buffer >= stats.ledge_buffer):
				change_state.emit(ledge_state_name)
				return

	#should idle
	if(Vector2(movement.velocity.x, movement.velocity.z).is_zero_approx()):
		change_state.emit(idle_state_name)
		return

func on_confirm() -> void:
	change_state.emit(roll_state_name)
