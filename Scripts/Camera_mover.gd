extends Camera3D

@export var lerpY : float = 0.03
@export var offsetX : float = 0.25
@export var offsetY : float = 0.25

func _physics_process(delta: float) -> void:
	if manager_singleton.instance().player != null:
		position.x = manager_singleton.instance().player.position.x + offsetX
		position.y = lerp(position.y,manager_singleton.instance().player.position.y + offsetY,lerpY) 
