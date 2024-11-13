extends ShapeCast3D
@export var action_number : int = 0
func _physics_process(delta: float) -> void:
	if is_colliding():
		if action_number == 0:
			action_0()
		elif action_number == 1:
			action_1()
		elif action_number == 2: 
			action_2()
		elif action_number == 3:
			action_3()
		elif action_number == 4:
			action_4() 

func action_0():
	manager_singleton.instance().player._player_died()
func action_1():
	if Input.is_action_pressed("jump") and not manager_singleton.instance().player.consumed_buffer:
		manager_singleton.instance().player._jump()
		manager_singleton.instance().player.consumed_buffer = true # consume the buffer
		action_number = -1 # dissable this interactable

func action_2():
	manager_singleton.instance().player.speed_multiplier = 1.5
	action_number = -1

func action_3():
	if Input.is_action_pressed("jump") and not manager_singleton.instance().player.consumed_buffer:
		manager_singleton.instance().player._jump()
		manager_singleton.instance().player.consumed_buffer = true # consume the buffer
		manager_singleton.instance().player.gravity_flipped = not manager_singleton.instance().player.gravity_flipped
		action_number = -1
	
func action_4():
	manager_singleton.instance().player.speed_multiplier = 0
	action_number = -1
