class_name InputComponent extends Node

signal confirm_pressed
signal cancel_pressed
signal targeting_changed

signal move_camera(move_x : float, move_y : float, mouse : bool)

@export var mouse_sens : float = 0.5
@export var stick_sens : float = 1.0

func _process(_delta: float) -> void:
	var look_dir := get_look_direction()
	if(look_dir):
		move_camera.emit(look_dir.x, look_dir.y, false)

func _unhandled_input(event: InputEvent) -> void:
	if(event.is_action_pressed("confirm")):
		confirm_pressed.emit()
	elif(event.is_action_pressed("cancel")):
		cancel_pressed.emit()
	elif(event is InputEventMouseMotion):
		move_camera.emit(event.relative.x, event.relative.y, true)
	elif(event.is_action_pressed("target") or event.is_action_released("target")):
		targeting_changed.emit()


func get_input_direction() -> Vector2:
	return Input.get_vector("left", "right", "forward", "back")

func get_look_direction() -> Vector2:
	return Input.get_vector("look_left", "look_right", "look_up", "look_down")
