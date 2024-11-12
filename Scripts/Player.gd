extends RigidBody3D
class_name Player

@export var default_gravity : float = 0.05
@export var jump_vel : float = 1.5
@export var default_x_vel : float = 0.0075

@onready var down_raycast = $down_cast
@onready var up_raycast = $up_cast
@onready var hurtbox = $hurtbox


var current_gravity : float = default_gravity

func _ready() -> void:
	manager_singleton.instance().player = self

func _physics_process(delta: float) -> void:
	_tick_input()
	_tick_gravity()
	_tick_scroll()
	_tick_die()

func _tick_scroll():
	position.x += default_x_vel
func _tick_gravity():
	linear_velocity.y -= current_gravity

func _tick_die():
	if hurtbox.is_colliding():
		_player_died()

func _tick_input():	
	if Input.is_action_pressed("jump") and down_raycast.is_colliding(): #jump
		linear_velocity.y = jump_vel

var prev_x = null
var expected_rate
func _tick_fix_x_alignment():
	if prev_x == null:
		prev_x = position.x
		return

func _player_died():
	manager_singleton.instance().player_died()
	
