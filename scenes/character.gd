@icon("res://meta/assets/character.png")
extends CharacterBody2D

const SPEED = 60
const HOE_LIMIT = 2

#var inventory_and_stats
var times_hoed = 0
var state: String # gets set to 'idle' in `_ready`
var direction = 'down'
var current_plant: GardenPlot
var current_tree: FruitTree
var current_mailbox: Mailbox
var current_water_well: WaterWell
var current_workstation: Workstation
var watering_happened = false

var stats_and_inventory : StatsAndInventory
@export var start_position : Vector2i

# Called when the node enters the scene tree for the first time.
func _ready():
	stats_and_inventory = StatsAndInventory.new()
	position = (start_position * LevelGenerationUtil.TILE_SIZE) + LevelGenerationUtil.HALF_TILE_CELL
	Events.select_garden_plot.connect(_handle_event_select_garden_plot)
	Events.select_fruit_tree.connect(_handle_event_select_fruit_tree)
	Events.select_mailbox.connect(_handle_event_select_mailbox)
	Events.select_water_well.connect(_handle_event_select_water_well)
	Events.select_workstation.connect(_handle_event_select_workstation)

	Events.perform_action.connect(_handle_event_perform_action)
	Events.select_seed_type.connect(_handle_event_select_seed_type)
	Events.harvest_fruit.connect(_handle_event_harvest_fruit)
	Events.harvest_plant.connect(_handle_event_harvest_plant)
	Events.update_actions.connect(_handle_event_update_actions)
	set_water_stuff()
	set_state('idle')

func set_water_stuff():
	Events.set_water_level_max.emit(stats_and_inventory.water_level_max)
	Events.set_water_level.emit(stats_and_inventory.water_level)

func set_start_position(v: Vector2i):
	start_position = v
	position = (start_position * LevelGenerationUtil.TILE_SIZE) + LevelGenerationUtil.HALF_TILE_CELL 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	handle_input(delta)
	play_state_animation()
	process_state_action()
#	position_focus_indicator()

func process_state_action():
	pass

func handle_input(delta):
	if Input.is_action_pressed("water"):
		set_state('water')
		return

	watering_happened = false
	$AnimatedWater.visible = false

	if Input.is_action_just_pressed("hoe"):
		set_state('hoe')
	
	if Input.is_action_pressed("chop"):
		set_state('chop')
		return

func play_state_animation():
	var animation_name = "%s_%s" % [state, direction]
#	print('play_state_animation %s' % animation_name)
	$AnimatedSprite2D.play(animation_name)
	if state == 'water' and direction != 'up':
		$AnimatedWater.visible = true
		$AnimatedWater.play('water_%s' % direction)

#func position_focus_indicator():
#	var focus_coords = LevelGenerationUtil.convert_to_grid_coordinates($AoI/FocusCursor.global_position)
#	$Focus.global_position = focus_coords * LevelGenerationUtil.TILE_SIZE

func position_to_coords(p: Vector2) -> Vector2i:
	return Vector2i((p - Vector2(LevelGenerationUtil.HALF_TILE_CELL)) / LevelGenerationUtil.TILE_SIZE)

func coords_to_position(p: Vector2i) -> Vector2:
	return (p * LevelGenerationUtil.TILE_SIZE) + LevelGenerationUtil.HALF_TILE_CELL

var path = []
var final_direction

func go_to_position(destination: Vector2i, options: Dictionary = {}):
	set_state('walk')
	var here = position_to_coords(position)
	var path_data = LevelUtil.find_path(here, destination, options)
	path = path_data['path']
	final_direction = path_data['direction']
	go_to_next_position()

func go_to_next_position():
	var coord = path.pop_front()
	if not coord:
		set_direction(final_direction)
		await get_tree().create_timer(.5).timeout
		set_state('idle')
		return
	move_to(coord)

func move_to(p: Vector2i):
	var new_position = coords_to_position(p)
	var t = get_tree().create_tween()
	var duration = .5 * (Vector2(new_position).distance_to(position) / LevelGenerationUtil.TILE_SIZE)
	set_state('walk')
	_set_direction_from_vectors(position, new_position)
	t.tween_property(self, 'position', new_position, duration)
	Common.character_position = p
	t.tween_callback(go_to_next_position)

func _set_direction_from_vectors(from: Vector2, to: Vector2):
	if from.y > to.y:
		set_direction('up')
	if from.x > to.x:
		set_direction('left')
	if from.x < to.x:
		set_direction('right')
	if from.y < to.y:
		set_direction('down')

func _on_ao_i_area_entered(area):
	print('an area entered AoI')
	if area is GardenPlot:
		current_plant = area
	elif area is FruitTree:
		current_tree = area
	elif area is Mailbox:
		current_mailbox = area
		current_mailbox.on_character_entered()
	elif area is WaterWell:
		current_water_well = area
	elif area is Workstation:
		current_workstation = area


func _on_ao_i_area_exited(area):
	print('an area exited AoI')
	if current_plant == area:
		current_plant = null
	if current_tree == area:
		current_tree = null
	if current_mailbox == area:
		current_mailbox.on_character_exited()
		current_mailbox = null
	elif current_water_well == area:
		current_water_well = null
	elif current_workstation == area:
		current_workstation = null
	set_actions()


func _on_animated_water_animation_finished():
	$AnimatedWater.visible = false


func _on_animated_sprite_2d_animation_looped():
	if state == 'hoe' and not current_tree:
		times_hoed += 1
		if times_hoed == HOE_LIMIT:
			times_hoed = 0
			var coordinates = Common.convert_to_grid_coordinates($AoI/FocusCursor.global_position)
			LevelUtil.add_plantable_tile(coordinates)
			set_state('idle')


func _on_animated_sprite_2d_animation_finished():
	if state == 'chop':
		if current_tree:
			current_tree.get_chopped()
		set_state('idle')

	if state == 'water' and current_plant:
		if not watering_happened:
			current_plant.get_watered()
			watering_happened = true
			stats_and_inventory.water_level -= 1
			set_water_stuff()
		set_state('idle')

func _handle_event_select_garden_plot(garden_plot: GardenPlot):
	print('a garden plot was selected... do something with it? display a context menu??')
	var here = position_to_coords(position)
	var garden_plot_coordinates = Common.convert_to_grid_coordinates(garden_plot.position)
	go_to_position(garden_plot_coordinates)

func _handle_event_select_fruit_tree(fruit_tree: FruitTree):
	var here = position_to_coords(position)
	var fruit_tree_coordinates = Common.convert_to_grid_coordinates(fruit_tree.position)
	go_to_position(fruit_tree_coordinates, { 'avoid': 'down' })

func _handle_event_select_mailbox(mailbox: Mailbox):
	var here = position_to_coords(position)
	var mailbox_coordinates = Common.convert_to_grid_coordinates(mailbox.position)
	go_to_position(mailbox_coordinates, { 'avoid': 'down' })

func _handle_event_select_water_well(well: WaterWell):
	var here = position_to_coords(position)
	var well_coordinates = Common.convert_to_grid_coordinates(well.position)
	go_to_position(well_coordinates, { 'only': 'up' })

func _handle_event_select_workstation(workstation: Workstation):
	var here = position_to_coords(position)
	var workstation_coordinates = Common.convert_to_grid_coordinates(workstation.position)
	go_to_position(workstation_coordinates, { 'only': 'up' })

func _handle_event_perform_action(action: Constants.ACTIONS):
	if action == Constants.ACTIONS.Menu:
		Events.open_menu.emit(stats_and_inventory)
	elif action == Constants.ACTIONS.RefillWater:
		refill_water_can()
	elif action == Constants.ACTIONS.WorkAtStation:
		Events.open_workstation_menu.emit(stats_and_inventory)
	elif action == Constants.ACTIONS.CheckMail:
		pass
	elif action == Constants.ACTIONS.Chop:
		set_state('chop')
	elif action == Constants.ACTIONS.Water:
		set_state('water')
	elif action == Constants.ACTIONS.Hoe:
		set_state('hoe')
	elif action == Constants.ACTIONS.Sow:
		facilitate_sowing()
	else: # probably harvest; future actions (like a quest letter) should be handled before here
		harvest_plant(action)

func _handle_event_select_seed_type(seed_type: Constants.VEGETABLE_TYPE):
	current_plant.set_type(seed_type)
	set_state('idle', true)

func _handle_event_harvest_fruit(fruit: Constants.FRUIT_TYPE):
	print('add this fruit to your inventory: %s' % fruit)
	stats_and_inventory.fruit_inventory[fruit] += 1
	await get_tree().create_timer(.2).timeout
	print(stats_and_inventory.fruit_inventory[fruit])
	set_actions()

func _handle_event_harvest_plant(plant: Constants.VEGETABLE_TYPE):
	print('add this plant to your inventory: %s' % plant)
	stats_and_inventory.plant_inventory[plant] += 1
	await get_tree().create_timer(.2).timeout
	print(stats_and_inventory.plant_inventory[plant])
	set_actions()

func harvest_plant(action_type: Constants.ACTIONS):
	if current_plant and current_plant.get_harvest_action() == action_type:
		current_plant.harvest()

func _handle_event_update_actions():
	set_actions()

func refill_water_can():
	set_state('processing')

	while stats_and_inventory.water_level < stats_and_inventory.water_level_max:
		await get_tree().create_timer(.5).timeout
		stats_and_inventory.water_level += 1
		set_water_stuff()

	set_state('idle')

func facilitate_sowing():
	Events.display_seed_options.emit([Constants.VEGETABLE_TYPE.Tomato, Constants.VEGETABLE_TYPE.Cucumber, Constants.VEGETABLE_TYPE.Pumpkin])
	print('await seed selection or dismissal')
	print('decrement seed count if applicable')

func set_direction(new_direction):
	if direction == new_direction:
		return
	direction = new_direction
	var r = {
		"up": 0,
		"down": PI,
		"right": PI / 2,
		"left": PI * 1.5,
	}[direction]
	$AoI.rotation = r

func set_state(new_state: String, force_update = false):
	if state == new_state and not force_update:
		return
	state = new_state
	await get_tree().create_timer(.3).timeout
	set_actions()

func set_actions():
	var actions = [Constants.ACTIONS.Menu]

	if state == 'idle':
		if current_plant:
			if current_plant.type == Constants.VEGETABLE_TYPE.None:
				actions.push_back(Constants.ACTIONS.Sow)
			elif current_plant.is_ready():
				actions.push_back(current_plant.get_harvest_action())
			elif stats_and_inventory.water_level > 0: # present greyed out water that would take you to the well
				actions.push_back(Constants.ACTIONS.Water)
		elif current_tree and stats_and_inventory.has_axe:
			actions.push_back(Constants.ACTIONS.Chop)
		elif current_mailbox: # and if there is a letter...
			print('and if there is a letter')
			actions.push_back(Constants.ACTIONS.CheckMail)
		elif current_water_well and stats_and_inventory.water_level < stats_and_inventory.water_level_max:
			actions.push_back(Constants.ACTIONS.RefillWater)
		elif current_workstation:
			actions.push_back(Constants.ACTIONS.WorkAtStation)
		elif LevelUtil.is_hoeable(position_to_coords($AoI/FocusCursor.global_position)) and stats_and_inventory.has_hoe:
			actions.push_back(Constants.ACTIONS.Hoe)
		
	Events.set_actions.emit(actions)
