extends Node
class_name manager_singleton
var _instance = null
var player : Player = null 

func player_died():
	_get_tree().change_scene_to_file("res://Scenes/main.tscn")

static func instance() -> manager_singleton:
	if not Engine.has_singleton("manager_singleton"):
		var singleton = manager_singleton.new()
		Engine.register_singleton("manager_singleton", singleton)
	return Engine.get_singleton("manager_singleton")

func _ready():
	pass


func _get_tree(): # returns the scene tree
	var main_loop = Engine.get_main_loop()
	var tree = main_loop as SceneTree
	return tree

func _spawn_explosion(position : Vector3, type : int):
	var obj = null
	if type == 1:
		obj = preload("res://Scenes/explode_effect.tscn")
	if type == 2:
		obj = preload("res://Scenes/explode_effect_2.tscn")
	if type == 3:
		obj = preload("res://Scenes/explode_effect_3.tscn")
		
		
	var nobj = obj.instantiate()
	nobj.position = position
	instance().player.children_parent.add_child(nobj)
