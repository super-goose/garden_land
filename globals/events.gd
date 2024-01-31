# class_name Events
extends Node

signal select_garden_plot(garden_plot: GardenPlot)
signal select_fruit_tree(fruit_tree: FruitTree)
signal perform_action(action: Constants.ACTIONS)
signal select_seed_type(type: Constants.PLANT_TYPE)
signal set_actions(actions: Array)
signal display_seed_options(seeds: Array)
signal hide_seed_options
