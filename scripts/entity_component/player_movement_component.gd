class_name PlayerMovementComponent extends Node

@export var body : CharacterBody3D
@export var stats : MovementStats
@export var movement_enabled : bool = true
@export var input : InputComponent
@export var face_with_node : Node3D
@export var model_container : Node3D
@export var movement_spatial : Node3D
@export var anim_player : AnimationPlayer

var velocity : Vector3:
	get: return body.velocity
	set(value): body.velocity = value

func _ready() -> void:
	assert(body, "forgot to set body on player movement component")
	assert(stats, "forgot to set stats on player movement component")
	assert(input, "forgot to set input component on player movement component")
	assert(model_container)
	assert(movement_spatial)

func _physics_process(delta: float) -> void:
	if(movement_enabled): body.move_and_slide()

func handle_gravity(delta : float, multiplier : float = 1.0) -> void:
	velocity.y -= stats.gravity_speed * delta * multiplier

func get_move_direction() -> Vector3:
	var move_dir : Vector3
	var input_dir := input.get_input_direction()
	if(face_with_node):
		move_dir = (face_with_node.basis * Vector3(input_dir.x,0.0,input_dir.y)).normalized()
	else:
		move_dir = Vector3(input_dir.x,0.0,input_dir.y).normalized()
	return move_dir

func handle_air_control(delta : float) -> void:
	var move_dir := get_move_direction()
	if(move_dir):
		velocity.x = clampf(
			velocity.x + stats.air_speed * move_dir.x * delta * stats.air_control_percentage,
			-stats.max_air_speed,
			stats.max_air_speed
		)
		velocity.z = clampf(
			velocity.z + stats.air_speed * move_dir.z * delta * stats.air_control_percentage,
			-stats.max_air_speed,
			stats.max_air_speed
		)
