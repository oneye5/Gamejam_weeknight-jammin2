extends ShapeCast3D
@export var action_number : int = 0
func _physics_process(delta: float) -> void:
	if is_colliding():
		if action_number == 0:
			action_0()
		elif action_number == 1:
			action_1()

func action_0():
	manager_singleton.instance().player._player_died()
func action_1():
	if Input.is_action_pressed("jump") and not manager_singleton.instance().player.consumed_buffer:
		manager_singleton.instance().player._jump()
		manager_singleton.instance().player.consumed_buffer = true # consume the buffer
		action_number = -1 # dissable this interactable
