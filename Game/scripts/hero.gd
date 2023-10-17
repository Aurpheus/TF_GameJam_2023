extends CharacterBody2D


const SPEED = 80.0
const JUMP_VELOCITY = -200.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_sneaking : bool = false
var is_hidden : bool = false
var interactive_areas : Array[Area2D] = []

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	var direction = Input.get_axis("ui_left", "ui_right")
	
	if Input.is_action_pressed("ui_up")  and is_on_floor() and interactive_areas.size() > 0: # replace with check if item that can hide 
		
		var area : Area2D = interactive_areas[interactive_areas.size()-1]
		if area.is_in_group("hide"):
			hide_in(area)
			return	
	if Input.is_action_just_pressed("ui_left"):
		$Area2D/CollisionShapeLeft.disabled = false
		$Area2D/CollisionShapeRight.disabled = true
	elif Input.is_action_just_pressed("ui_right"):
		$Area2D/CollisionShapeLeft.disabled = true
		$Area2D/CollisionShapeRight.disabled = false

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		print("position: ",position.x , " ", position.y)
		velocity.y = JUMP_VELOCITY
	elif Input.is_action_pressed("sneak") and is_on_floor():
		is_sneaking = true
		velocity.x =  direction * SPEED * 0.66
		move_and_slide()
		return
	
	reset_sprite()
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func reset_sprite():
	is_sneaking = false
	modulate = Color(1,1,1)
	z_index = 0

func hide_in(area: Area2D):
	velocity.x = 0
	velocity.y = 0
	var Shape:RectangleShape2D = area.get_node("CollisionShape2D").shape
	
	modulate = Color(0.5,0.5,0.5)
	
	# probably 
	position.x = area.get_parent().position.x # + Shape.size.x
	position.y = area.get_parent().position.y + Shape.size.y/4
	z_index = -1
	
	is_hidden = true

func _on_area_2d_area_entered(area  : Area2D):
	print("entered by", area.name)
	interactive_areas.append(area)


func _on_area_2d_area_exited(area : Area2D):
	print("exited by", area.name)
	var t : Array[Area2D]= []
	for interactive_area in interactive_areas:
		if area != interactive_area:
			t.append(area)
	interactive_areas = t
