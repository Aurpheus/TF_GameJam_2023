extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	load_default_map()
	
func load_default_map():
	var inst = load("res://scenes/levels/intro/test_level.tscn").instantiate()
	inst.spawnIndex = 0
	$Level.add_child(inst)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		get_hero().get_node("Camera2D").enabled = !get_hero().get_node("Camera2D").enabled
		$menuCam.enabled = !$menuCam.enabled
		$menus/pause.visible = !$menus/pause.visible
		get_tree().paused = !get_tree().paused
	pass

func pause():
	print("pause !")
	
func get_hero():	
	return $Level/Level/Hero

