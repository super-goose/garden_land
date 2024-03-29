# class_name Events
extends Node

signal select_garden_plot(garden_plot: GardenPlot)
signal select_fruit_tree(fruit_tree: FruitTree)
signal select_mailbox(mailbox: Mailbox)
signal select_workstation(workstation: Workstation)
signal select_water_well(well: WaterWell)

signal quest_available

signal select_seed_type(type: Constants.VEGETABLE_TYPE)
signal perform_action(action: Constants.ACTIONS)
signal set_actions(actions: Array)
signal display_seed_options(seeds: Dictionary)
signal hide_seed_options
signal update_actions

signal harvest_fruit(item: Constants.FRUIT_TYPE, amount: int)
signal harvest_plant(item: Constants.VEGETABLE_TYPE, amount: int)
signal vegetable_was_harvested

signal set_water_level(value: int)
signal set_water_level_max(value: int)

signal open_menu(stats: StatsAndInventory, is_workstation: bool)
#signal open_workstation_menu(stats: StatsAndInventory)
signal close_menu

signal time_passage_pause
signal time_passage_play
signal time_passage_fast_forward
signal increase_hour(hour: int, am_pm: Constants.TIME)
signal become_day
signal become_night
signal start_new_day
signal start_raining
signal stop_raining
