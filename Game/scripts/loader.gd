extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	load_default_map()
	
func load_default_map():
	var inst = load("res://scenes/levels/intro/hallway1.tscn").instantiate()
	inst.spawnIndex = 0
	add_child(inst)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
