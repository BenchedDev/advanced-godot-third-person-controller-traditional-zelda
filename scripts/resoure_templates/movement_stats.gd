class_name MovementStats extends Resource

@export var move_speed : float = 500.0
@export var gravity_speed : float = 36.0
@export_group("Roll")
@export var roll_speed : float = 13.0
@export var roll_duration : float = 0.75
@export var roll_buffer_percentage : float = 0.75
@export_group("Air Control")
@export var air_control_enabled : bool = true
@export_range(0,1,.1) var air_control_percentage : float = 0.1
@export var air_speed : float = 300.0
@export var max_air_speed : float = 9.0
@export_group("Jumps & Hops")
@export_subgroup("Jump")
@export var jump_velocity : float = 8.0
@export var jump_speed : float = 9.0
@export_subgroup("Obstacle Hop")
@export var hop_velocity : float = 10.0
@export var hop_speed : float = 8.0
@export var hop_buffer : float = 0.2 # in seconds
@export_group("Ledge")
@export var ledge_buffer : float = 0.3 # in seconds
@export_group("Size Information")
@export var height : float = 2
@export var half_width : float = 0.3
