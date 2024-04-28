extends Node3D

@export var h_rot : Node3D
@export var v_rot : Node3D

@export var input : InputComponent

@export var target : Node3D
@export var target_speed : float = 15.0


var targeting : bool = false

func _ready() -> void:
	assert(h_rot and v_rot)
	assert(input)
	input.move_camera.connect(move_cam)
	input.targeting_changed.connect(on_targeting_changed)

func _physics_process(delta: float) -> void:
	if(targeting):
		if(target):
			h_rot.rotation_degrees.y = lerpf(
				h_rot.rotation_degrees.y,
				target.rotation_degrees.y + 180,
				delta * target_speed
				)
			v_rot.rotation_degrees.x = lerpf(
				v_rot.rotation_degrees.x,
				0.0,
				delta * target_speed
			)

func move_cam(move_x : float, move_y : float, mouse : bool) -> void:
	if(mouse):
		h_rot.rotation_degrees.y = wrapf(h_rot.rotation_degrees.y - move_x * input.mouse_sens, 0 , 360)
		v_rot.rotation_degrees.x = clampf(v_rot.rotation_degrees.x - move_y * input.mouse_sens, -90, 90)
	else:
		h_rot.rotation_degrees.y = wrapf(h_rot.rotation_degrees.y - move_x * input.stick_sens, 0 , 360)
		v_rot.rotation_degrees.x = clampf(v_rot.rotation_degrees.x - move_y* input.stick_sens, -90, 90)

func on_targeting_changed() -> void:
	targeting = Input.is_action_pressed("target")
