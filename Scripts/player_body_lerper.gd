extends Node3D

@export var pos_lerp : float = 0.1
var prev_pos : Vector3 = Vector3.ONE

func _process(delta: float) -> void:
	lerp_pos()
	handle_rotate(delta)

func lerp_pos() -> void:
	position = lerp(position, prev_pos, pos_lerp)
	prev_pos = manager_singleton.instance().player.position

func handle_rotate(delta) -> void:
	if manager_singleton.instance().player.down_raycast.is_colliding():
		rotation_degrees.z = round(rotation_degrees.z/90.0)*90.0 # snap to closest 90 deg increment
	else:
		if not manager_singleton.instance().player.gravity_flipped:
			rotation_degrees.z -= manager_singleton.instance().player.rotate_speed * delta / (1.0/120.0)
		else:
			rotation_degrees.z += manager_singleton.instance().player.rotate_speed * delta / (1.0/120.0)
