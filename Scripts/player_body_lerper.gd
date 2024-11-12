extends Node3D
@export var acceptable_distance = 0.02
var prev_pos : Vector3 = Vector3.ONE

func _process(delta: float) -> void:
	lerp_pos()
	handle_rotate(delta)

func lerp_pos() -> void:
	prev_pos = manager_singleton.instance().player.position
	
	var xDist = abs(position.x - prev_pos.x)
	var yDist = abs(position.y - prev_pos.y)
	var scale_factor_x = max(0.01,1.0 - (acceptable_distance / xDist)) / 1.5 # this does not need to be exact
	var scale_factor_y = max(0.01,1.0 - (acceptable_distance / xDist)) * 1.5 # it is nice when this is responsive
	
	position.x = lerp(position.x, prev_pos.x + acceptable_distance,  scale_factor_x) 
	position.y = lerp(position.y, prev_pos.y , scale_factor_y)

func handle_rotate(delta) -> void:
	if manager_singleton.instance().player.down_raycast.is_colliding():
		rotation_degrees.z = round(rotation_degrees.z/90.0)*90.0 # snap to closest 90 deg increment
	else:
		if not manager_singleton.instance().player.gravity_flipped:
			rotation_degrees.z -= manager_singleton.instance().player.rotate_speed * delta / (1.0/120.0)
		else:
			rotation_degrees.z += manager_singleton.instance().player.rotate_speed * delta / (1.0/120.0)
