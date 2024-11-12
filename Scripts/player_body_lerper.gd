extends Node3D

@export var pos_lerp : float = 0.01
@export var rot_lerp : float = 0.2
var prev_pos : Vector3 = Vector3.ONE
var prev_rot : float = 0

func _process(delta: float) -> void:
	position = lerp(position,prev_pos,pos_lerp)
	rotation_degrees.z = lerp(rotation.z,prev_rot,rot_lerp) * 10.0
	prev_pos = manager_singleton.instance().player.position
	prev_rot = manager_singleton.instance().player.visual_rot
	print(prev_rot)
  
