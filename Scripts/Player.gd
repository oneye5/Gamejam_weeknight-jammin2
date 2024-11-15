extends RigidBody3D
class_name Player

@export var default_gravity : float = 0.05
@export var jump_vel : float = 1.5
@export var default_x_vel : float = 0.0061
@export var rotate_speed : float = 3
@export var death_anim_time : float = 1.5

@onready var visual_mesh = $"../Mesh_transform"
@onready var down_raycast = $down_cast
@onready var up_raycast = $up_cast
@onready var hurtbox = $hurtbox
@onready var children_parent = $"../child_bricks"
@onready var percent_label = $"../Player_UI/percent"
@onready var current_gravity : float = default_gravity
var consumed_buffer = false # this becomes consumed when the player clicks on a jump block, they need to click again to reset
var speed_multiplier = 1
var gravity_flipped = false
var dead = false
@onready var remaining_death_anim_time = death_anim_time

@onready var xPos = position.x

func _ready() -> void:
	manager_singleton.instance().player = self

func _physics_process(delta: float) -> void:
	if not dead:
		_tick_input()
		_tick_gravity()
		_tick_scroll()
		_tick_grav_flip()
		_tick_UI()
	_tick_die(delta)

func _tick_UI():
	percent_label.text = str( round( (position.x/50.4) * 100.0 ) ) + " %"

func _tick_scroll():
	xPos += speed_multiplier * default_x_vel
	position.x = xPos

func _tick_gravity():
	if not gravity_flipped:
		linear_velocity.y -= current_gravity
	else: 
		linear_velocity.y += current_gravity

func _tick_die(delta):
	if dead:
		remaining_death_anim_time -= delta
		if remaining_death_anim_time < 0:
			manager_singleton.instance().player_died()
	elif hurtbox.is_colliding():
		_player_died()

func _place_block():
	var grid_size_x = 0.08
	var grid_size_y = 0.064
	
	var block_pos = position
	#snap to grid
	block_pos.x = round(block_pos.x / grid_size_x) * grid_size_x
	block_pos.y = round(block_pos.y / grid_size_y) * grid_size_y
	#offset
	if not gravity_flipped:
		block_pos.y -= grid_size_y * 2
	else:
		block_pos.y += grid_size_y * 3
	block_pos.x += grid_size_x * 1
	var block = preload("res://Scenes/spawned_block.tscn")
	var new_block = block.instantiate()
	new_block.position = block_pos
	children_parent.add_child(new_block)
	manager_singleton.instance()._spawn_explosion(block_pos,3)
	

func _tick_input():	
	if Input.is_action_just_pressed("jump"):
		consumed_buffer = false
	
	if Input.is_action_pressed("jump") and down_raycast.is_colliding(): #jump
		_jump()
		
	if Input.is_action_just_pressed("place"):
		_place_block()

func _jump():
	if not gravity_flipped:
		linear_velocity.y = jump_vel
	else:
		linear_velocity.y = -jump_vel

func _player_died():
	if dead:
		return
	
	dead = true
	manager_singleton.instance()._spawn_explosion(position,2)

func _tick_grav_flip():
	if gravity_flipped:
		rotation_degrees.z = -180.0
	else:
		rotation_degrees.z = 0.0
