extends Node2D

@export var spawnPoints : Array[Vector2] = []
@export var spawnIndex : int = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	startup()

func startup():
	if spawnPoints.size() > 0:
		var inst = load("res://scenes/hero.tscn").instantiate()
		inst.position.x  = spawnPoints[spawnIndex].x
		inst.position.y  = spawnPoints[spawnIndex].y
		add_child(inst)
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
