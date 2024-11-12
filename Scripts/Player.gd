extends RigidBody3D
class_name Player

@export var default_gravity : float = 0.05
@export var jump_vel : float = 1.5
@export var default_x_vel : float = 0.0075

@onready var down_raycast = $down_cast
@onready var up_raycast = $up_cast
@onready var hurtbox = $hurtbox
@onready var children_parent = $"../child_bricks"


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

func _place_block():
	var grid_size_x = 0.08
	var grid_size_y = 0.064
	
	var block_pos = position
	#snap to grid
	block_pos.x = round(block_pos.x / grid_size_x) * grid_size_x
	block_pos.y = round(block_pos.y / grid_size_y) * grid_size_y
	#offset
	block_pos.y -= grid_size_y * 2
	block_pos.x += grid_size_x * 2
	var block = preload("res://Scenes/spawned_block.tscn")
	var new_block = block.instantiate()
	new_block.position = block_pos
	children_parent.add_child(new_block)
	

func _tick_input():	
	if Input.is_action_pressed("jump") and down_raycast.is_colliding(): #jump
		linear_velocity.y = jump_vel
	if Input.is_action_just_pressed("place"):
		_place_block()

var prev_x = null
var expected_rate
func _tick_fix_x_alignment():
	if prev_x == null:
		prev_x = position.x
		return

func _player_died():
	manager_singleton.instance().player_died()
	
