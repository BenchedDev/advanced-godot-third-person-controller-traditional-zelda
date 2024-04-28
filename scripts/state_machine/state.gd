class_name State extends Node

signal change_state(new_state_name : String)

var state_name : String:
	get: return name

func init_state() -> void:
	pass

func enter_state() -> void:
	pass

func exit_state() -> void:
	pass

func state_process(_delta : float) -> void:
	pass

func state_physics_process(_delta : float) -> void:
	pass
