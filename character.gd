extends CharacterBody2D

const SPEED = 40

var state = 'idle'
var direction = 'down'
var current_plant: GardenPlot
var current_tree: FruitTree
var watering_happened = false
@export var start_position : Vector2i

# Called when the node enters the scene tree for the first time.
func _ready():
	position = start_position * 16

func set_start_position(v: Vector2i):
	start_position = v
	position = start_position * 16

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	handle_input(delta)
	play_state_animation()
	process_state_action()

func process_state_action():
	if current_plant:
		if state == 'water':
			if watering_happened == true:
				return
			current_plant.increase_stage()
			watering_happened = true

func handle_input(delta):
	if Input.is_action_pressed("water"):
		state = "water"
		return

	watering_happened = false
	$AnimatedWater.visible = false

	if Input.is_action_pressed("hoe"):
		if not current_tree:
			state = "hoe"
		return
	
	if Input.is_action_pressed("chop"):
		state = "chop"
		return

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
	if state == 'water' and direction != 'up':
		$AnimatedWater.visible = true
		$AnimatedWater.play('water_%s' % direction)



func _on_ao_i_area_entered(area):
	if area is GardenPlot:
		current_plant = area
	elif area is FruitTree:
		current_tree = area

func _on_ao_i_area_exited(area):
	if current_plant == area:
		current_plant = null
	if current_tree == area:
		current_tree = null


func _on_animated_water_animation_finished():
	$AnimatedWater.visible = false


func _on_animated_sprite_2d_animation_looped():
	
	if state == 'chop' and current_tree:
		current_tree.get_chopped()
#	if $AnimatedSprite2D.animation:
#		pass
