class_name PlayerMovementState extends State

var movement : PlayerMovementComponent

var stats : MovementStats:
	get: return movement.stats

func init_state() -> void:
	super.init_state()
	assert(movement, "%s does not have a movement component" % state_name)

func enter_state() -> void:
	super.enter_state()
	movement.input.confirm_pressed.connect(on_confirm)
	movement.input.cancel_pressed.connect(on_cancel)

func exit_state() -> void:
	movement.input.confirm_pressed.disconnect(on_confirm)
	movement.input.cancel_pressed.disconnect(on_cancel)


func on_confirm() -> void:
	pass

func on_cancel() -> void:
	pass
