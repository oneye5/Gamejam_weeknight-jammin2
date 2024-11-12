extends Node3D
@export var pos_lerp_y : float = 0.5
@export var pos_lerp_x : float = 0.02
var prev_pos : Vector3 = Vector3.ONE

func _process(delta: float) -> void:
	lerp_pos()
	handle_rotate(delta)

func lerp_pos() -> void:
	position.x = lerp(position.x, prev_pos.x + 0.025 , pos_lerp_x) 
	position.y = lerp(position.y, prev_pos.y , pos_lerp_y)
	prev_pos = manager_singleton.instance().player.position

func handle_rotate(delta) -> void:
	if manager_singleton.instance().player.down_raycast.is_colliding():
		rotation_degrees.z = round(rotation_degrees.z/90.0)*90.0 # snap to closest 90 deg increment
	else:
		if not manager_singleton.instance().player.gravity_flipped:
			rotation_degrees.z -= manager_singleton.instance().player.rotate_speed * delta / (1.0/120.0)
		else:
			rotation_degrees.z += manager_singleton.instance().player.rotate_speed * delta / (1.0/120.0)
