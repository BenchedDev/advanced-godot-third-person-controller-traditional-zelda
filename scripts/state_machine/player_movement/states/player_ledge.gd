extends PlayerMovementState


@export var head_ray : RayCast3D
@export var head_down_ray : RayCast3D

@export var idle_state_name : String = "Idle"

func init_state() -> void:
	super.init_state()
	assert(head_ray and head_down_ray)

func enter_state() -> void:
	super.enter_state()
	if(movement.anim_player):
		movement.anim_player.stop()
		movement.anim_player.play("ledge")
	movement.velocity = Vector3.ZERO
	movement.model_container.look_at(movement.model_container.global_position + head_ray.get_collision_normal())
	movement.body.position = head_down_ray.get_collision_point() + Vector3(0,-stats.height,0) + stats.half_width * -movement.model_container.basis.z

func on_cancel() -> void:
	change_state.emit(idle_state_name)

func on_confirm() -> void:
	movement.body.position = head_down_ray.get_collision_point()
	change_state.emit(idle_state_name)
