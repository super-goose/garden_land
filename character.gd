extends CharacterBody2D

const SPEED = 30

var state = 'idle'
var direction = 'down'

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	handle_movement(delta)
	play_state_animation()

func handle_movement(delta):
	var movement_direction = Vector2.ZERO
	if Input.is_action_pressed("go_up"):
		movement_direction += Vector2.UP
	if Input.is_action_pressed("go_down"):
		movement_direction += Vector2.DOWN
	if Input.is_action_pressed("go_left"):
		movement_direction += Vector2.LEFT
	if Input.is_action_pressed("go_right"):
		movement_direction += Vector2.RIGHT
	
	if movement_direction.length():
		state = "walk"
		
		if abs(movement_direction.x) > abs(movement_direction.y):
			direction = "left" if movement_direction.x < 0 else "right"
		else: #if abs(movement_direction.y) > abs(movement_direction.x):
			direction = "up" if movement_direction.y < 0 else "down"
	else:
#		direction = "down"
		state = "idle"

	velocity = movement_direction.normalized() * SPEED
	var r = {
		"up": 0,
		"down": PI,
		"right": PI / 2,
		"left": PI * 1.5,
	}[direction]
#	print(r)
	$AoI.rotation = r
	move_and_slide()

func play_state_animation():
	var animation_name = "%s_%s" % [state, direction]
	$AnimatedSprite2D.play(animation_name)


func _on_ao_i_area_entered(area: GardenPlot):
	print(area.type)
	print(area.stage)
	
