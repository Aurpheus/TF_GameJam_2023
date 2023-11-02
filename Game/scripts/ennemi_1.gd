extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@export var AI_Model_Path : String = "res://scripts/AIModels/dumbAI.gd"

var AIModel = null

func _init():
	load_AI_Model(AI_Model_Path)


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	if(!AIModel.move(self)):
		velocity.x = move_toward(velocity.x, 0, SPEED)
	# Handle Jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
	#	velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#var direction = Input.get_axis("ui_left", "ui_right")
	#if direction:
	#	velocity.x = direction * SPEED
	#else:

	move_and_slide()

func load_AI_Model(path : String):
	AIModel = load(path).new()

func _on_area_2d_body_entered(body):
	if body.is_in_group("hero"):
		body.process_ennemy(name)
