extends CanvasLayer
func _ready() -> void:
	process_mode = PROCESS_MODE_ALWAYS
	get_tree().paused = true 

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		if visible:
			visible = false
			get_tree().paused = false
		else:
			visible = true
			get_tree().paused = true 
