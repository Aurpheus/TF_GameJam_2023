extends AIModel

const SPEED = 40.0

func move(node : Node2D):
	node.velocity.x = -1 * SPEED
	return true
	
