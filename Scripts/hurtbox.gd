extends ShapeCast3D
func _physics_process(delta: float) -> void:
	if is_colliding():
		manager_singleton.instance().player._player_died()
